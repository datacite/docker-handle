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

INSERT INTO `handles` VALUES ('TEST/ADMIN',100,_binary 'HS_ADMIN',_binary '�\0\0\0\nTEST/ADMIN\0\0\0\�',0,86400,1533122317,'',1,1,1,0),('TEST/ADMIN',300,_binary 'HS_SECKEY',_binary 'ASECRETKEY',0,86400,1533122431,'',1,1,0,0);
INSERT INTO `nas` VALUES ('0.NA/TEST'),('TEST');