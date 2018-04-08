			var bannerSwiper = new Swiper('.banner-swiper',{
				pagination : '.swiper-pagination',
				paginationClickable :true,
				autoplay : 3000,
				onSlideChangeStart: function(swiper){ 
				      // alert(swiper.activeIndex);
				      $(".banner-info").hide();
				      $(".banner-info").eq(swiper.activeIndex).show();
				    }
			})
			var featureSwiper = new Swiper('.feature-banner',{
				  pagination: '.swiper-pagination',
				  paginationClickable: true,
				  paginationBulletRender: function (swiper, index, className) {
				      return '<span class="' + className + '">' + (index + 1) + '</span>';
				  }
			})
			$(function(){
				$(".hover-link").mouseenter(function() {
					var $img = $(".introduce-content");
					var $index = $(this).index();
					$img.removeClass('fadein');
					$img.eq($index).addClass('fadein');
				});
				$(".tab").click(function() {
					var $parent = $(this).parents(".tab-wrap");
					var $index = $(this).index();
					$parent.find(".tab").removeClass("active");
					$(this).addClass("active");
					$parent.find(".unit")
							.css("display","none")
							.eq($index).css("display","block");

				});
			})