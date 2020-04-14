# CISC 3500 Database Systems Project
- This was a course project where a database was given, and the task was to write a python script that takes command line arguments and translate them into sqlite squeries.
- Works in a Linux environment, and needs Python 3.
- Use:
  1. Clone all files into a working directory.
  2. Enter the following in bash.
    ```
    cd create-database
    run_parser.sh
    create_database.sh
    cd ..
    python3 Command_Line_Input.py <command>
    ```
- "<command>" takes the form of
  ```
  search [min=<real number>] [max=<real number>] [category=<real number>]
  ```
  or
  ```
  bid item_id=<item_id_number> bidder_id=<bidder_id_number> amount=<some positive number>
  ```
