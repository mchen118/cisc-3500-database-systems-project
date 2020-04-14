--description <prevents insertion of bids before the auction start time and after the aution end time>

pragma foreign_keys = on;
drop trigger if exists trigger11;
create trigger trigger11 before insert on bids
  when (select strftime('%Y%m%d%H%M%S',new.time)) < (select strftime('%Y%m%d%H%M%S',(select started
                                                                                     from items
                                                                                     where item_id = new.item_id))) 
        or
       (select strftime('%Y%m%d%H%M%S',new.time)) > (select strftime('%Y%m%d%H%M%S',(select ends
                                                                                     from items
                                                                                     where item_id = new.item_id)))
  begin
  select raise(fail, 'Constraint 11 violated: Bid time cannot be before auction start time or after auction end time.');
  end;