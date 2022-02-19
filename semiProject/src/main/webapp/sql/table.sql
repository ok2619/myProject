/*회원관리*/
create table qmember(
	user_num number not null,
    id varchar2(10) unique not null,
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
    reg_date date default sysdate not null, --상품등록일
    constraint qproduct_pk primary key (product_num)
 );
create sequence qproduct_seq;
 
 create table qcart(
    cart_num number not null,
    product_num number not null, 
    user_num number not null, 
    cart_count number not null, --장바구니에 담은 수량
    constraint qcart_pk primary key (cart_num),
    constraint qcart_fk1 foreign key (user_num) references qmember (user_num),
    constraint qcart_fk2 foreign key (product_num) references qproduct (product_num)
 );
create sequence qcart_seq;
 
 create table qorder(
    order_num number not null,
    user_num number not null,
    item_name varchar2(600) not null, --주문상품명
    order_total number(9) not null, --주문금액
    payment number(1) not null, --주문방식(1.계좌이체, 2.카드결제)
    shipping number default 1 not null, --배송상태(1.제품 준비중 2.제품 발송 3.배송완료)
    reg_date date default sysdate not null, --주문날짜
    order_name varchar2(30) not null, --추가*
    order_post varchar2(5) not null, --추가*
    order_address1 varchar2(90) not null, --추가 *
    order_address2 varchar2(90) not null, --추가*
    order_phone varchar2(15) not null, --추가*
    constraint qorder_pk primary key (order_num),
    constraint qorder_fk foreign key (user_num) references qmember (user_num)
 );
create sequence qorder_seq;

 create table qorder_detail(
 	orderdetail_num number not null, --pk
    order_num number not null, --fk
    product_num number not null, -- fk
    cart_count number(7) not null,--item_quantity에서 이름 변경
    product_name varchar2(30) not null, --추가*
 	product_price number(8) not null, --추가*
 	product_total number(8) not null, --추가*
    constraint qorder_detail_pk primary key (orderdetail_num),
    constraint qorder_detail_fk1 foreign key (order_num) references qorder (order_num),
    constraint qorder_detail_fk2 foreign key (product_num) references qproduct (product_num)
 );
create sequence qorder_detail_seq;
 
/*게시판*/
create table qboard(
 board_num number not null,
 title varchar2(150) not null,
 b_content clob not null,
 hit number(5) default 0 not null,
 reg_date date default sysdate not null,
 modify_date date,
 filename varchar2(100),
 ip varchar2(40) not null,
 user_num number not null,
 constraint qboard_pk primary key (board_num),
 constraint qboard_fk foreign key (user_num) references qmember (user_num)
);
create sequence qboard_seq;

/*댓글*/
create table qboard_reply(
 re_num number not null,
 re_content varchar2(900) not null,
 re_date date default sysdate not null,
 re_modifydate date,
 re_ip varchar2(40) not null,
 board_num number not null, 
 user_num number not null,
 constraint qreply_pk primary key (re_num),
 constraint qreply_fk1 foreign key (board_num) references qboard (board_num),
 constraint qreply_fk2 foreign key (user_num) references qmember (user_num)
);
create sequence qreply_seq;

/*좋아요*/
create table qboard_fav(
  fav_num number not null,
  fav_date date default sysdate not null,
  board_num number not null,
  user_num number not null,
  constraint fav_pk primary key (fav_num),
  constraint fav_fk1 foreign key (board_num) references qboard (board_num),
  constraint fav_fk2 foreign key (user_num) references qmember (user_num)    
);

create sequence qfav_seq;
