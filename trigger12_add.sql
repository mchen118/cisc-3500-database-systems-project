-- description: <prevents insertion of a bid with existing bidder_id, item_id and amount>

pragma foreign_keys = on;
drop trigger if exists trigger12;
create trigger trigger12 before insert on bids        
  begin
  select 
  case
  when (new.amount = (select amount
                      from bids
                      where bidder_id = new.bidder_id and item_id = new.item_id))
  then raise (fail, 'Constraint 12 violated: No user can bid on the same item with the same amount more than once.')
  end;
  end;

  
  
