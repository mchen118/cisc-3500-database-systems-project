--description <prevents update on currentTime that moves date_time backwards>

pragma foreign_keys = on;
drop trigger if exists trigger16;
create trigger trigger16 before update on currentTime
  begin
  select
  case
  when (select strftime('%Y%m%d%H%M%S',new.date_time)) < (select strftime('%Y%m%d%H%M%S',old.date_time))
  then raise(fail, 'Constraint 16 violated: date_time cannot move backwards.')
  end;
  end