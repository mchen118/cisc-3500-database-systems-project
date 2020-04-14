import sqlite3
import sys


def search_with_category():
  global c
  min_price = '0'
  max_price = 'infinity'
  
  for arg in arg_list:
      if 'min' in arg:
        min_price = arg.partition('=')[2]
      elif 'max' in arg:
        max_price = arg.partition('=')[2]
      elif 'category' in arg:
        category = arg.partition('=')[2]
        
  c.execute(''' 
            select name, currently
            from items inner join categories using (item_id)
            where (currently >= ?) and (category == ? collate nocase)
            
            intersect
            
            select name, currently
            from items inner join categories using (item_id)
            where (currently <=?) and (category == ? collate nocase)
            ''', (min_price, category, max_price, category))


def search_without_category():
  global c
  min_price = '0'
  max_price = 'infinity'
  
  for arg in arg_list:
      if 'min' in arg:
        min_price = arg.partition('=')[2]
      elif 'max' in arg:
        max_price = arg.partition('=')[2]
        
  c.execute(''' 
            select name, currently
            from items
            where (currently >= ?)
            
            intersect
            
            select name, currently
            from items
            where (currently <=?)
            ''', (min_price, max_price))


def add_a_bid():
  global c
  
  for arg in arg_list:
      if 'item_id' in arg:
        item_id = arg.partition('=')[2]
      elif 'bidder_id' in arg:
        bidder_id = arg.partition('=')[2]
      elif 'amount' in arg:
        amount = arg.partition('=')[2]
  c.execute('''
            insert into bids values (?,?,(select datetime('now')), ?)
            ''', (item_id, bidder_id, amount))


def print_result(c):
  print ('---------------')
  for row in c:
    print (row)
  print ('---------------')


def add_trigger(filepath):
  global c
  with open(filepath) as f:
    everything = f.read()
    c.executescript(everything)


if __name__ == "__main__":

  database = './AuctionBase.db'
  conn = sqlite3.connect(database)
  c = conn.cursor()
  
  c.execute('''pragma foreign_keys=on''')
  add_trigger('trigger9_add.sql')
  add_trigger('trigger8_add.sql')
  add_trigger('trigger7_add.sql')
  add_trigger('trigger16_add.sql')
  add_trigger('trigger15_add.sql')
  add_trigger('trigger14_add.sql')
  add_trigger('trigger13_add.sql')
  add_trigger('trigger12_add.sql')
  add_trigger('trigger11_add.sql')
  
  line_input = ' '.join(sys.argv)
  keyword = sys.argv [1]
  arg_list = sys.argv [2:]

  if keyword == 'search' and 'category' in line_input:
    search_with_category()
    print_result(c)
  
  if keyword == 'search' and 'category' not in line_input:
    search_without_category()
    print_result(c)

  if keyword == 'bid' or keyword == 'buy':
    add_a_bid()
    print_result(c)
 
  conn.commit()
  conn.close()