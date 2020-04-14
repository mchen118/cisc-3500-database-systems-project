--description: <updates currently to the most recent bid on the item>

pragma foreign_keys = on;
drop trigger if exists trigger8;
create trigger trigger8 after insert on bids
  begin
  update items set currently = new.amount
  where item_id = new.item_id;
  end;