--description: <prevents insertion of bids by its seller>

pragma foreign_keys = on;
drop trigger if exists trigger9;
create trigger trigger9 before insert on bids
  begin
  select
  case
  when (new.bidder_id = (select seller_id
                        from items
                        where item_id=new.item_id))
  then raise(fail,'Constraint 9 violated: Seller may NOT bid on what he/her is selling.')
  end;
  end;