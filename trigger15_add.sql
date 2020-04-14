--description <set bid time to current time after insertion>

pragma foreign_keys = on;
drop trigger if exists trigger15;
create trigger trigger15 after insert on bids
  begin
  update bids set time = datetime('now')
  where item_id = new.item_id;
  end;