<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="description" content="Foodeiblog Template">
<meta name="keywords" content="Foodeiblog, unica, creative, html">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<!-- csrf간련 데이터 저장 -->
<meta name="csrfHeaderName" content="${_csrf.headerName}">
<meta name="csrfTokenValue" content="${_csrf.token}">

<title>쇼핑몰</title>

<!-- Google Font -->
<link
	href="https://fonts.googleapis.com/css?family=Nunito+Sans:300,400,600,700,800,900&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css?family=Unna:400,700&display=swap"
	rel="stylesheet">

<!-- Css Styles -->
<link rel="stylesheet"
	href="/shoppingmall/resources/css/bootstrap.min.css" type="text/css">
<link rel="stylesheet"
	href="/shoppingmall/resources/css/font-awesome.min.css" type="text/css">
<link rel="stylesheet"
	href="/shoppingmall/resources/css/fontawesome.min.css" type="text/css">
<link rel="stylesheet" 
	href="https://forkaweso.me/Fork-Awesome/assets/fork-awesome/css/fork-awesome.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" integrity="sha512-+4zCK9k+qNFUR5X+cKL9EIR+ZOhtIloNl9GIKS57V1MyNsYpYcUrUeQc9vNfzsWfV28IaLL3i96P9sdNyeRssA==" crossorigin="anonymous" />	
 <link rel="stylesheet"
	href="/shoppingmall/resources/css/elegant-icons.css" type="text/css">
<link rel="stylesheet"
	href="/shoppingmall/resources/css/owl.carousel.min.css" type="text/css">
<link rel="stylesheet"
	href="/shoppingmall/resources/css/slicknav.min.css" type="text/css">
<link rel="stylesheet" href="/shoppingmall/resources/css/style.css"
	type="text/css">
<link rel="stylesheet"
	href="/shoppingmall/resources/css/bootstrap-theme.min.css">
<!-- <link rel="stylesheet"
	href="/shoppingmall/resources/css/all.css" type="text/css"> -->
<!-- Js Plugins -->
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="/shoppingmall/resources/js/bootstrap.min.js"></script>
<script src="/shoppingmall/resources/js/jquery.slicknav.js"></script>
<script src="/shoppingmall/resources/js/owl.carousel.min.js"></script>
<style>
.top-bar {
	height: 32px;
	top: 0;
	right: 0;
	left: 0;
}

.top-bar-menu {
	float: right;
	position: relative;
	margin-right: 10%;
	font-family: 돋움, Dotum, sans-serif;
	font-size: 13px;
}

.top-bar-menu-item {
	margin-right: 10px;
}

a:link {
	text-decoration: none;
	color: #646464;
}

a:active {
	text-decoration: none;
	color: #646464;
}

a:visited {
	text-decoration: none;
	color: #646464;
}

A:hover {
	text-decoration: none;
	color: #646464;
}
.title-font {
	font-size: 48px;
	margin-left: 5px;
}

@media ( max-width :740px) {
	.title-font {
		font-size: 25px;
		margin-left: 5px;
		font-weight: bold;
	}
}
</style>
</head>

<body>
	<!-- Page Preloder -->
	<div id="preloder">
		<div class="loader"></div>
	</div>

	<div class="humberger__menu__overlay"></div>
	<div class="humberger__menu__wrapper">
		<nav class="humberger__menu__nav mobile-menu">
			<ul>
				<li class="dropdown">
					<a href="/shoppingmall/common/main">
						<i class="fa fa-gift" style="margin-right: 5px;font-size: 20px; color: #FFFFFF"></i>판매상품
					</a>
					<ul class="dropdown__menu">
						<li><a href="/shoppingmall/common/main?category=B" style="font-size: 12px">뷰티</a></li>
						<li><a href="/shoppingmall/common/main?category=L" style="font-size: 12px">생활용품</a></li>
						<li><a href="/shoppingmall/common/main?category=F" style="font-size: 12px">식품</a></li>
						<li><a href="/shoppingmall/common/main?category=C" style="font-size: 12px">패션의류/잡화</a></li>
					</ul>
				</li>
				<li><a href="/shoppingmall/common/basket"><i class="fa fa-shopping-cart" style="margin-right: 5px;font-size: 20px; color: #FFFFFF"></i>장바구니</a></li>
				<li><a href="/shoppingmall/member/orderInfo"><i class="fas fa-receipt" style="margin-right: 5px;font-size: 20px; color: #FFFFFF"></i>주문내역</a></li>
				<li><a href="/shoppingmall/member/myPage"><i class="fa fa-user" style="margin-right: 5px;font-size: 20px; color: #FFFFFF"></i>내 정보</a></li>
				<sec:authorize access="hasRole('ROLE_SELLER')">
					<div class="col-sm-12" style="margin-top: 10px;border-top: 1px solid white;padding: 10px">
						<i class="fa fa-arrow-down" aria-hidden="true"></i>판매자 목록
					</div>
					<li><a href="/shoppingmall/seller/regProduct">상품등록</a></li>
					<li><a href="/shoppingmall/seller/myProducts">판매 중 상품</a></li>
					<li><a href="/shoppingmall/seller/sellerInfo">거래내역</a></li>
				</sec:authorize>
				<sec:authorize access="hasRole('ROLE_ADMIN')">
					<div class="col-sm-12" style="margin-top: 10px;border-top: 1px solid white;padding: 10px">
						<i class="fa fa-arrow-down" aria-hidden="true"></i>관리자 목록
					</div>
					<li><a href="/shoppingmall/admin/showSellerRequests">판매자 신청 현황</a></li>
				</sec:authorize>
			</ul>
		</nav>
		<div id="mobile-menu-wrap"></div>
		<div class="humberger__menu__about">
		</div>

	</div>
	<!-- Humberger End -->

	<!-- Header Section Begin -->
	<header class="header">
		<article class="top-bar">
			<div class="top-bar-menu">
				<sec:authorize access="isAnonymous()">
					<span class="top-bar-menu-item"><a href="/shoppingmall/common/login">로그인</a></span>
					<span class="top-bar-menu-item"><a href="/shoppingmall/common/register">회원가입</a></span>
				</sec:authorize>
						
				<sec:authorize access="isAuthenticated()">
					<form id="logoutForm" action="/shoppingmall/member/doLogout" method="post">
						<sec:csrfInput/>
					</form>
					<span id="logoutBtn" class="top-bar-menu-item" style="cursor: pointer;">로그아웃</span>
					<span class="top-bar-menu-item"><a href="/shoppingmall/member/myPage">내정보</a></span>
					<script>
						$("#logoutBtn").on("click", function() {
							$("#logoutForm").submit();
						});
					</script>
				</sec:authorize>
			</div>
		</article>
		<div class="container">
			<div class="row">
				<div class="col-lg-3 col-md-3">
					<div class="header__btn"></div>
				</div>
				<div class="col-lg-6 col-md-6">
					<div class="header__logo">
						<a href="/shoppingmall/common/main"><img
							src="/shoppingmall/resources/img/coupong.png" alt=""></a>
					</div>
				</div>
				<div class="col-lg-3 col-md-3"></div>
			</div>
		</div>
		<div class="header__top" style="margin-bottom: 30px">
			<div class="container">
				<div class="row">
					<div class="col-lg-2 col-md-1 col-6 order-md-1 order-1">
						<div class="header__humberger">
							<i class="fa fa-bars humberger__open"></i>
						</div>
					</div>
					<div class="col-lg-8 col-md-10 order-md-2 order-3">
						<nav class="header__menu">
							<ul>
								<li class="dropdown"><a href="/shoppingmall/common/main"><i class="fa fa-gift" style="margin-right: 5px;font-size: 20px; color: #ccc"></i>판매상품</a>
									<ul class="dropdown__menu">
										<li><a href="/shoppingmall/common/main?category=B">뷰티</a></li>
										<li><a href="/shoppingmall/common/main?category=L">생활용품</a></li>
										<li><a href="/shoppingmall/common/main?category=F">식품</a></li>
										<li><a href="/shoppingmall/common/main?category=C">패션의류/잡화</a></li>
									</ul>
								</li>
								 
								<li><a href="/shoppingmall/common/basket"><i class="fa fa-shopping-cart" style="margin-right: 3px;font-size: 20px; color: #FF00FF"></i>장바구니</a></li>
								<li><a href="/shoppingmall/member/orderInfo"><i class="fas fa-receipt" style="margin-right: 3px;font-size: 20px; color: #000000"></i>주문내역</a></li>
							</ul>
						</nav>
					</div>
					<div class="col-lg-2 col-md-1 col-6 order-md-3 order-2">
						<div class="header__search">
						</div>
					</div>
				</div>
			</div>
		</div>
	</header>
	 