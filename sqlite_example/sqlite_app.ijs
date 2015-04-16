NB. Simple script to show basic SQLite functionality with J. The example database
NB. is a store for user passwords. Since it is all in plaintext,
NB. this is only useful as a basic example of J's interface with
NB. sqlite.
NB. @author Jon Hough
NB. @since 16 April 2015

require'data/ddsqlite'
 
db=: ''conew'jddsqlite'
 
]ch =. ddcon__db'database=',(jpath'~temp/passwords.db'),';nocreate=0'


'create table if not exists passwords (id numeric, pword text)' ddsql__db ch


NB. add new password
insert =: dyad define
database =. x
query =. y
query ddsql__db database
)

NB. example db insertion
ch insert 'insert into passwords (id, pword) values (1, ''mysecret'')'
