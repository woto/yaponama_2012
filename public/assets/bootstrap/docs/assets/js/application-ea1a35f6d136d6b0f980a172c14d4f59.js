/*!
 * JavaScript for Bootstrap's docs (http://getbootstrap.com)
 * Copyright 2011-2014 Twitter, Inc.
 * Licensed under the Creative Commons Attribution 3.0 Unported License. For
 * details, see http://creativecommons.org/licenses/by/3.0/.
 */
!function($){$(function(){if(navigator.userAgent.match(/IEMobile\/10\.0/)){var msViewportStyle=document.createElement("style");msViewportStyle.appendChild(document.createTextNode("@-ms-viewport{width:auto!important}")),document.querySelector("head").appendChild(msViewportStyle)}{var $window=$(window),$body=$(document.body);$(".navbar").outerHeight(!0)+10}$body.scrollspy({target:".bs-docs-sidebar"}),$window.on("load",function(){$body.scrollspy("refresh")}),$(".bs-docs-container [href=#]").click(function(e){e.preventDefault()}),setTimeout(function(){var $sideBar=$(".bs-docs-sidebar");$sideBar.affix({offset:{top:function(){var offsetTop=$sideBar.offset().top,sideBarMargin=parseInt($sideBar.children(0).css("margin-top"),10),navOuterHeight=$(".bs-docs-nav").height();return this.top=offsetTop-navOuterHeight-sideBarMargin},bottom:function(){return this.bottom=$(".bs-docs-footer").outerHeight(!0)}}})},100),setTimeout(function(){$(".bs-top").affix()},100),$(".tooltip-demo").tooltip({selector:"[data-toggle=tooltip]",container:"body"}),$(".tooltip-test").tooltip(),$(".popover-test").popover(),$(".bs-docs-navbar").tooltip({selector:"a[data-toggle=tooltip]",container:".bs-docs-navbar .nav"}),$("[data-toggle=popover]").popover(),$("#loading-example-btn").click(function(){var btn=$(this);btn.button("loading"),setTimeout(function(){btn.button("reset")},3e3)})})}(jQuery);