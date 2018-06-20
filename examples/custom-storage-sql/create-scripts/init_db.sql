/* Base handle schema */

create table nas (
    na varchar(255) not null,
    PRIMARY KEY(na)
);

create table handles (
    handle varchar(255) not null,
    idx int4 not null,
    type blob,
    data blob,
    ttl_type int2,
    ttl int4,
    timestamp int4,
    refs blob,
    admin_read bool,
    admin_write bool,
    pub_read bool,
    pub_write bool,
    PRIMARY KEY(handle, idx)
);

/* Populate handle database with test data */

