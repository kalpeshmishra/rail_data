!function(n){n.fn.jPushMenu=function(s){var e=n.extend({},n.fn.jPushMenu.defaultOptions,s);n("body").addClass(e.bodyClass),n(this).addClass("jPushMenuBtn"),n(this).click(function(){var s="",t="";return n(this).is("."+e.showLeftClass)?(s=".cbp-spmenu-left",t="toright"):n(this).is("."+e.showRightClass)?(s=".cbp-spmenu-right",t="toleft"):n(this).is("."+e.showTopClass)?s=".cbp-spmenu-top":n(this).is("."+e.showBottomClass)&&(s=".cbp-spmenu-bottom"),n(this).toggleClass(e.activeClass),n(s).toggleClass(e.menuOpenClass),n(this).is("."+e.pushBodyClass)&&n("body").toggleClass("cbp-spmenu-push-"+t),n(".jPushMenuBtn").not(n(this)).toggleClass("disabled"),!1});var t={close:function(){n(".jPushMenuBtn,body,.cbp-spmenu").removeClass("disabled active cbp-spmenu-open cbp-spmenu-push-toleft cbp-spmenu-push-toright")}};e.closeOnClickInside&&(n(document).click(function(){t.close()}),n(".cbp-spmenu,.toggle-menu").click(function(s){s.stopPropagation()})),e.closeOnClickOutside&&(n(document).click(function(){t.close()}),n(".cbp-spmenu,.toggle-menu").click(function(s){s.stopPropagation()}))},n.fn.jPushMenu.defaultOptions={bodyClass:"",activeClass:"menu-active",showLeftClass:"menu-left",showRightClass:"menu-right",showTopClass:"menu-top",showBottomClass:"menu-bottom",menuOpenClass:"cbp-spmenu-open",pushBodyClass:"push-body",closeOnClickOutside:!0,closeOnClickInside:!0}}(jQuery);