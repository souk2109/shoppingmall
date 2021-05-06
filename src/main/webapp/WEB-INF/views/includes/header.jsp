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
	href="/shoppingmall/resources/css/elegant-icons.css" type="text/css">
<link rel="stylesheet"
	href="/shoppingmall/resources/css/owl.carousel.min.css" type="text/css">
<link rel="stylesheet"
	href="/shoppingmall/resources/css/slicknav.min.css" type="text/css">
<link rel="stylesheet" href="/shoppingmall/resources/css/style.css"
	type="text/css">
<link rel="stylesheet"
	href="/shoppingmall/resources/css/bootstrap-theme.min.css">

<!-- Js Plugins -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
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
				<li class="dropdown"><a href="#">카테고리</a>
					<ul class="dropdown__menu">
						<li><a href="./categories-grid.html" style="font-size: 12px">식료품</a></li>
						<li><a href="./categories-list.html" style="font-size: 12px">가구</a></li>
						<li><a href="./single-post.html" style="font-size: 12px">의류</a></li>
						<li><a href="./signin.html" style="font-size: 12px">신발</a></li>
						<li><a href="./404.html" style="font-size: 12px">등등</a></li>
						<li><a href="./typography.html" style="font-size: 12px">뭐하지</a></li>
					</ul></li>
				<li><a href="#">할인상품</a></li>
				<li><a href="#">내 정보</a></li>
				<li><a href="#">주문정보</a></li>
				<li><a href="#">찜 목록</a></li>
				<sec:authorize access="hasRole('ROLE_SELLER')">
					<div align="center" class="col-sm-12" style="margin-top: 10px; margin-bottom: 10px">------------ 판매자 카테고리 ------------</div>
					<li><a href="/shoppingmall/seller/regProduct">상품등록</a></li>
					<li><a href="/shoppingmall/seller/myProducts">판매 중 상품</a></li>
					<li><a href="/shoppingmall/seller/#">거래내역</a></li>
				</sec:authorize>
				<sec:authorize access="hasRole('ROLE_ADMIN')">
					<div align="center" class="col-sm-12" style="margin-top: 10px; margin-bottom: 10px">------------ 관리자 카테고리 ------------</div>
					<li><a href="/shoppingmall/admin/showSellerRequests">판매자 신청 보기</a></li>
				</sec:authorize>
			</ul>
		</nav>
		<div id="mobile-menu-wrap"></div>
		<div class="humberger__menu__about">
			<div class="humberger__menu__title sidebar__item__title">
				<h6>About me</h6>
			</div>
			<img src="/shoppingmall/resources/img/humberger/humberger-about.jpg"
				alt="">


			<div
				class="humberger__menu__about__social sidebar__item__follow__links">
				<a href="#"><i class="fa fa-facebook"></i></a> <a href="#"><i
					class="fa fa-twitter"></i></a> <a href="#"><i
					class="fa fa-youtube-play"></i></a> <a href="#"><i
					class="fa fa-instagram"></i></a> <a href="#"><i
					class="fa fa-envelope-o"></i></a>
			</div>
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
					<span class="top-bar-menu-item"><a href="/shoppingmall/member/doLogout">로그아웃</a></span>
					<span class="top-bar-menu-item"><a href="/shoppingmall/member/myPage">내정보</a></span>
				</sec:authorize>
				<span class="top-bar-menu-item"><a href="#">문의하기</a></span>
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
							src="/shoppingmall/resources/img/logo.png" alt=""></a>
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
								<li><a href="#">Recipes</a>
									<div class="header__megamenu__wrapper">
										<div class="header__megamenu">
											<div class="header__megamenu__item">
												<div class="header__megamenu__item--pic set-bg"
													data-setbg="/shoppingmall/resources/img/megamenu/p-1.jpg">
													<div class="label">Vegan</div>
												</div>
												<div class="header__megamenu__item--text">
													<h5>
														<a href="#">How to Make a Milkshake With Any Ice Cream
															...</a>
													</h5>
												</div>
											</div>
										</div>
									</div></li>
								<li><a href="#">Dinner</a></li>
								<li><a href="#">Desserts</a></li>
								<li class="dropdown"><a href="#">Pages</a>
									<ul class="dropdown__menu">
										<li><a href="./categories-grid.html">Categories Grid</a></li>
										<li><a href="./categories-list.html">Categories List</a></li>
									</ul></li>
								<li><a href="/shoppingmall/common/basket"><i class="fa fa-shopping-cart" style="margin-right: 3px;font-size: 20px; color: #FF00FF"></i>장바구니</a></li>
								
							</ul>
						</nav>
					</div>
					<div class="col-lg-2 col-md-1 col-6 order-md-3 order-2">
						<div class="header__search">
							<i class="fa fa-search search-switch"></i>
						</div>
					</div>
				</div>
			</div>
		</div>
	</header>