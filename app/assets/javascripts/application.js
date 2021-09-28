// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require chartkick
//= require Chart.bundle
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery
//= require jquery_ujs
//= require jquery.raty.js
//= require_tree .
//= require highcharts/highcharts
//= require highcharts/highcharts-more
//= require highcharts/highstock

$(document).on('turbolinks:load', function () {
  $("#images").skippr({
    // スライドショーの変化 ("fade" or "slide")
    transition : 'fade',
    // 変化に係る時間(ミリ秒)
    speed : 1500,
    // easingの種類
    easing : 'easeOutQuart',
    // ナビゲーションの形("block" or "bubble")
    navType : '',
    // 子要素の種類("div" or "img")
    childrenElementType : 'div',
    // ナビゲーション矢印の表示(trueで表示)
    arrows : false,
    // スライドショーの自動再生(falseで自動再生なし)
    autoPlay : true,
    // 自動再生時のスライド切替間隔(ミリ秒)
    autoPlayDuration : 2800,
    // キーボードの矢印キーによるスライド送りの設定(trueで有効)
    keyboardOnAlways : false,
    // 一枚目のスライド表示時に戻る矢印を表示するかどうか(falseで非表示)
    hidePrevious : false
  });
});


// カテゴリー多階層
$(document).on('turbolinks:load', function(){
  // カテゴリーの選択肢が入ったdiv
  var categoryBox = $('.form-details__form-box__category')
  // 親カテゴリー
  function appendOption(category) {
    var html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`
  }

  // 子カテゴリー
  function appendChildBox(insertHTML) {
    var childSelectHtml = '';
    childSelectHtml = `<div class='form-select' id="child-category">
                        <select class= 'select-default' name="product[category_ids][]">
                            <option value>---</option>
                            ${insertHTML}
                          </select>
                          <i class='fa fa-angle-down icon-angle-down'></i>
                      </div>`
    categoryBox.append(childSelectHtml);
  }

  // カテゴリーボックスで親カテゴリが変わった場合
  categoryBox.on("change", "#parent-category", function(){
    var parentCategory = $("parent-category").value;
    if(parentCategory !== "") {
      $.ajax ({
        url: '/products/get_category_children',
        type: "GET",
        data: {
          parent_id: parentCategory
        },
        dataType: 'json'
      })
      .done(function(children){
        $('#child-category').remove();
        $('#grandchild-category').remove();
        var insertHTML = '';
        children.forEach(function(grandchild){
          insertHTML += appendOption(grandchild);
        });
        appendGrandchildrenBox(insertHTML);
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    } else {
      //親カテゴリーが初期値（---)の場合、子カテゴリー以下は非表示にする
      //親カテゴリが未選択の場合、子、孫カテゴリの選択欄は非表示にしたいので、そのように変更
      $('#child-category').remove();
      $('#grandchild-category').remove();
      $('#size').remove();
    }
  })
})