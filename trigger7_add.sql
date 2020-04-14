-- description: <prevents insertion of new items which start time is after end time>

pragma foreign_keys = on;
drop trigger if exists trigger7;
create trigger trigger7 before insert on items
  when (select strftime('%Y%m%d%H%M%S',new.started)) > (select strftime('%Y%m%d%H%M%S',new.ends))
  begin
  select raise(fail, 'Constraint 7 violate: Auction start time must be before end time.');
  end;