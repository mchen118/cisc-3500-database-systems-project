--description <prevents insertion of bids which amount is not higher than currently>

pragma foreign_keys = on;
drop trigger if exists trigger14;
create trigger trigger14 before insert on bids
  when (new.amount < (select currently
                      from items
                      where item_id = new.item_id) or
        new.amount < (select first_bid
                      from items
                      where item_id = new.item_id))
  begin
  select raise(fail, 'Constraint 14 voilated: Bid amount must be higher than the most recent bid.');
  end;