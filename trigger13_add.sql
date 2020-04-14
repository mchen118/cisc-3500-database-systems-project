--description <updates num_of_bids to reflect the most recent insertion>

pragma foreign_keys = on;
drop trigger if exists trigger13;
create trigger trigger13 after insert on bids
  begin
  update items set num_of_bids = num_of_bids + 1
  where item_id = new.item_id;
  end;