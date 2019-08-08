!function(l){l.fn.customselect=function(t,s){var v={csclass:"custom-select",search:!0,numitems:4,searchblank:!1,showblank:!0,searchvalue:!1,hoveropen:!1,emptytext:"",showdisabled:!1,useoptionclass:!1,mobilecheck:function(){return navigator.platform&&navigator.userAgent.match(/(android|iphone|ipad|blackberry)/i)}};t&&"object"==typeof t&&l.extend(v,t);var o="function"==typeof v.mobilecheck?v.mobilecheck.call():v.mobilecheck;return(o?l(this).filter("select"):l(this).filter("select:not([multiple])")).each(function(){var u=l(this);u.data("cs-options")&&l.extend(v,u.data("cs-options"));var i=u.parents(v.selector+":first"),a={init:function(){var t={init:function(){t.container(),t.value(),t.subcontainer()},container:function(){i=l("<div/>").addClass(v.csclass),o&&(i.addClass(v.csclass+"-mobile"),u.css("opacity",0)),u.before(i),u.appendTo(i),u.off("change",t._onchange).change(t._onchange);var e=null;i.hover(function(){e&&clearTimeout(e),i.addClass(v.csclass+"-hover")},function(){v.hoveropen&&(e=setTimeout(a.close,750)),i.removeClass(v.csclass+"-hover")}),l(document).mouseup(function(){i.is(v.selector+"-open")&&(i.is(v.selector+"-hover")?i.find("input").focus():a.close())})},value:function(){var c=l("<a href='#'><span/></a>").appendTo(i);u.appendTo(i);var r="",d=null;c.click(function(e){e.preventDefault()}).focus(function(){i.addClass(v.csclass+"-focus")}).blur(function(){i.removeClass(v.csclass+"-focus")}),l("html").keyup(function(e){if(c.is(":focus")){var t=e.which,s=u.find("option").not(":disabled");if(48<=t&&t<=90){r+=String.fromCharCode(t).toLowerCase();for(var o=0;o<s.length;o++){var n=s.eq(o),i=(n.text()+"").toLowerCase();if((!n.is(":disabled")&&v.searchblank||0<i.length)&&0==i.indexOf(r)){u.val(n.attr("value")).change();break}}d&&clearTimeout(d),d=setTimeout(function(){r=""},1e3),e.preventDefault()}else if(27==t)d&&clearTimeout(d),r="",e.preventDefault();else if(38==t){var a=u.find("option:selected");0<(l=s.index(a))?u.val(s.eq(l-1).attr("value")):u.val(s.eq(s.length-1).attr("value")),u.change(),e.preventDefault()}else if(40==t){var l;a=u.find("option:selected");(l=s.index(a))<s.length-1?u.val(s.eq(l+1).attr("value")):u.val(s.eq(0).attr("value")),u.change(),e.preventDefault()}}});var e=u.find("option:selected");c.find("span").html(0<e.text().length?e.text():v.emptytext),c.removeAttr("class"),v.useoptionclass&&e.attr("class")&&c.addClass(e.attr("class")||""),v.hoveropen?c.mouseover(a.open):c.click(a.toggle)},subcontainer:function(){var e=l("<div/>").appendTo(i),t=l("<input type='input'/>").appendTo(e);t.keyup(function(e){l.inArray(e.which,[13,38,40])<0&&(v.search?a.search(l(this).val()):(a.searchmove(l(this).val()),l(this).val("")))}).keydown(function(e){switch(e.which){case 13:val=i.find("ul li.active.option-hover").data("value"),disabled=i.find("ul li.active.option-hover").is(".option-disabled"),a.select(val,disabled);break;case 38:a.selectUp();break;case 40:a.selectDown();break;case 27:a.close();break;default:return!0}return e.preventDefault(),!1}).blur(function(){l(this).val("")}),v.search||t.addClass(v.csclass+"-hidden-input");var s=l("<div/>").appendTo(e),n=l("<ul/>").appendTo(s);u.find("option").each(function(e){var t=l(this).attr("value"),s=l(this).text(),o=l(this).is(":disabled");!(v.showblank||0<t.length)||!v.showdisabled&&o||l("<li/>",{"class":"active"+(0==e?" option-hover":"")+(l(this).is(":disabled")?" option-disabled":"")+(v.useoptionclass&&l(this).attr("class")?" "+l(this).attr("class"):""),"data-value":t,text:0<s.length?s:v.emptytext}).appendTo(n)});var o=n.find("li");n.find("li").click(function(){a.select(l(this).data("value"),l(this).is(".option-disabled"))}),i.find("div div").css({"overflow-y":o.length>v.numitems?"scroll":"visible"}),l("<li/>",{"class":"no-results",text:"No results"}).appendTo(n)},_onchange:function(){u.val(l(this).val()),a.select(l(this).val())}};u.is("select"+v.selector)&&!u.data("cs-options")&&t.init()},toggle:function(){i.is(v.selector+"-open")?a.close():a.open()},open:function(){o||(i.addClass(v.csclass+"-open"),i.find("input").focus(),i.find("ul li.no-results").hide(),a._selectMove(u.get(0).selectedIndex))},close:function(){i.removeClass(v.csclass+"-open"),i.find("input").val("").blur(),i.find("ul li").not(".no-results").addClass("active");var e=i.find("ul li").not(".no-results");i.find("div div").css({"overflow-y":e.length>v.numitems?"scroll":"visible"}),i.find("a").focus()},search:function(o){o=l.trim(o.toLowerCase());var e=i.find("ul li.no-results").hide(),t=i.find("ul li").not(".no-results");t.each(function(){var e=(l(this).text()+"").toLowerCase(),t=(l(this).data("value")+"").toLowerCase(),s=!1;v.searchblank||0<t.length?v.searchvalue&&0<=t.indexOf(o)?s=!0:0<=e.indexOf(o)&&(s=!0):0==o.length&&(s=!0),s?l(this).addClass("active"):l(this).removeClass("active")}),t=t.filter(".active").filter(":visible"),i.find("div div").css({"overflow-y":t.length>v.numitems?"scroll":"visible"}),0<t.length?a._selectMove(0):e.show()},searchmove:function(t){var s=[];u.find("option").each(function(e){0==l(this).text().toLowerCase().indexOf(t.toLowerCase())&&s.push(e)}),0<s.length&&a._selectMove(s[0])},select:function(e,t){if(!t){u.val()!=e&&u.val(e).change();var s=u.find("option:selected"),o=i.find("a");o.find("span").text(0<s.text().length?s.text():v.emptytext),o.removeAttr("class"),v.useoptionclass&&s.attr("class")&&o.addClass(s.attr("class")||""),a.close()}},selectUp:function(){var e=i.find("ul li.active").not(".no-results"),t=e.index(e.filter(".option-hover"))-1;t=t<0?e.length-1:t,a._selectMove(t)},selectDown:function(){var e=i.find("ul li.active").not(".no-results"),t=e.index(e.filter(".option-hover"))+1;t=t>e.length-1?0:t,a._selectMove(t)},destroy:function(){u.data("cs-options")&&(u.removeData("cs-options").insertAfter(i),i.remove())},_selectMove:function(e){var t=i.find("ul li.active");t.removeClass("option-hover").eq(e).addClass("option-hover");var s=i.find("div div");if("scroll"==s.css("overflow-y")){s.scrollTop(0);var o=t.eq(e);offset=o.offset().top+o.outerHeight()-s.offset().top-s.height(),0<offset&&s.scrollTop(offset)}}},e=t;e&&"object"==typeof e&&(e="init",s=null),v.selector="."+v.csclass,"function"==typeof a[e=e||"init"]&&a[e].call(this,s),"destroy"!=e&&u.data("cs-options",v)}),this}}(jQuery);