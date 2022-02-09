/*회원관리*/
create table qmember(
    user_num number not null,
    user_id varchar2(10) unique not null,
    auth number(1) default 2 not null, /*회원등급:0탈퇴회원,1정지회원,2일반회원,3관리자*/
    constraint qmember_pk primary key (user_num)
);
create table qmember_detail(
    user_num number not null,
    name varchar2(30) not null,
    passwd varchar2(12) not null,
    phone varchar2(15) not null,
    zipcode varchar2(5) not null,
    address1 varchar2(90) not null,
    address2 varchar2(90) not null,
    reg_date date default sysdate not null,
    constraint qmember_detail_pk primary key (user_num),
    constraint qmember_detail_fk foreign key (user_num) references qmember (user_num)
 );
create sequence qmember_seq;

/*상품 관리*/
create table qproduct(
    product_num number not null, 
    stock number(9) not null, 
    product_name varchar2(100) not null,
    sort varchar2(20) not null, 
    price number(10) not null, 
    image varchar2(100) not null,
    content clob,
    preg_date date default sysdate not null,
    constraint qproduct_pk primary key (product_num)
 );
create sequence qproduct_seq;
 
 create table qcart(
    cart_num number not null,
    product_num number not null, --장바구니 담을 상품명
    user_id number not null, --장바구니 이용 회원 아이디 
    cart_count number not null, --담은 수량
    cart_regdate date default sysdate not null, --담은 날짜
    constraint 장바구니pk primary key (cart_num),
    constraint 회원번호fk foreign key (user_id) references 회원관리(user_id)
 );
 --시퀀스
 
 create table qorder(
    order_num number not null,
    user_id number not null, --주문한 회원 아이디 
    order_regdate date default sysdate not null,
    constraint 주문pk primary key (order_num),
    constraint 회원번호fk foreign key (user_id) references 회원관리(user_id)
 );
 --시퀀스
 create table qorder_detail		
(
    d_order_num number not null,
    order_num number not null,
    product_num number not null,
    d_dorder_count number,
    d_shipping number(1) default 1 not null, --배송전 1, 배송후 2
    constraint 상세주문pk primary key (d_order_num),
    constraint 주문번호fk foreign key (order_num) references 주문(order_num),
    constraint 상품fk foreign key (product_num) references 주문(product_num)
 );
 --시퀀스
 
/*게시판*/
create table zboard(
 board_num number not null,
 title varchar2(150) not null,
 content clob not null,
 hit number(5) default 0 not null,
 reg_date date default sysdate not null,
 modify_date date,
 filename varchar2(150),
 ip varchar2(40) not null,
 mem_num number not null,
 constraint zboard_pk primary key (board_num),
 constraint zboard_fk foreign key (mem_num) references zmember (mem_num)
);
create sequence zboard_seq;

/*댓글*/
create table zboard_reply(
 re_num number not null,
 re_content varchar2(900) not null,
 re_date date default sysdate not null,
 re_modifydate date,
 re_ip varchar2(40) not null,
 board_num number not null, /*부모글에 딸려있으니까 board_num 받아야됨*/
 mem_num number not null,
 constraint zreply_pk primary key (re_num),
 constraint zreply_fk1 foreign key (board_num) references zboard (board_num),
 constraint zreply_fk2 foreign key (mem_num) references zmember (mem_num)
);
create sequence zreply_seq;