# mysqldump version control helper

Remember to backup your database! The `mysqldump` program makes this easy,
but a small bash function can make it even easier.

Suppose you have a superuser for your MySQL database called `rewt` with a cool `p4ssw0rd`.
You have two databases, `foo` and `bar`, that you want to backup from time to time.

Add the following to your `~/.bashrc`:

```
. /path/to/sqldump.sh
. ~/.bashrc.private
alias foo_dump='db_dump foo'
alias bar_dump='db_dump bar'
```

Create a `.bashrc.private`, readable only by you, with the password to your database:

```
db_dump() {
	db_dump_base "$1" 'rewt' 'p4ssw0rd'
}
```

Create Git repositories for `foo` and `bar`:

```
mkdir ~/sqldump
git init ~/sqldump/foo
git init ~/sqldump/bar
```

Now, you can run `foo_dump` and `bar_dump` at any time to make a fresh
mysqldump backup of either database.
