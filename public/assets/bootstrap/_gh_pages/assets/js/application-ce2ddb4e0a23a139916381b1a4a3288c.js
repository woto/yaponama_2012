!function($){$(function(){var $window=$(window),$body=$(document.body),navHeight=$(".navbar").outerHeight(!0)+10;$body.scrollspy({target:".bs-sidebar",offset:navHeight}),$window.on("load",function(){$body.scrollspy("refresh")}),$(".bs-docs-container [href=#]").click(function(e){e.preventDefault()}),setTimeout(function(){var $sideBar=$(".bs-sidebar");$sideBar.affix({offset:{top:function(){var offsetTop=$sideBar.offset().top,sideBarMargin=parseInt($sideBar.children(0).css("margin-top"),10),navOuterHeight=$(".bs-docs-nav").height();return this.top=offsetTop-navOuterHeight-sideBarMargin},bottom:function(){return this.bottom=$(".bs-footer").outerHeight(!0)}}})},100),setTimeout(function(){$(".bs-top").affix()},100),$(".tooltip-demo").tooltip({selector:"[data-toggle=tooltip]",container:"body"}),$(".tooltip-test").tooltip(),$(".popover-test").popover(),$(".bs-docs-navbar").tooltip({selector:"a[data-toggle=tooltip]",container:".bs-docs-navbar .nav"}),$("[data-toggle=popover]").popover(),$("#fat-btn").click(function(){var btn=$(this);btn.button("loading"),setTimeout(function(){btn.button("reset")},3e3)}),$(".bs-docs-carousel-example").carousel()})}(window.jQuery);