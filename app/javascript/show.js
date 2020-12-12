$(function(){
  $(".btn-gnavi").on("click", function(){
      // ハンバーガーメニューの位置を設定
      var rightVal = 0;
      if($(this).hasClass("open")) {
          // 位置を移動させメニューを開いた状態にする
          rightVal = -300;
          // メニューを開いたら次回クリック時は閉じた状態になるよう設定
          $(this).removeClass("open");
      } else {
          // メニューを開いたら次回クリック時は閉じた状態になるよう設定
          $(this).addClass("open");
      }

      $("#tweet-navi").stop().animate({
          right: rightVal
      }, 200);
  });
});

// 自動リロード
// $(function(){
//   setTimeout(function(){
//     location.reload();
//   },9000);
// });