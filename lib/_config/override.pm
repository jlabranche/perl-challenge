package _config::override;

sub init {
    return {
        db_port => '3306',
        db_host => 'localhost',
        db_name => 'trucks',
        db_user => 'root',
        #db_pass => 'password',
    }
}

1;
