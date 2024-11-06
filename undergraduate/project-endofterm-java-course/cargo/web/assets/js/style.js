$(document).ready(function () {
    $(".sidebar_menu li").click(function () {
        $(".sidebar_menu li").removeClass("active");
        $(this).addClass("active");
    })
    $(".hamburger").click(function () {
        $(".wrapper").addClass("active");
    })
    $(".bg_shadow,.close").click(function () {
        $(".wrapper").removeClass("active");
    })
})

// 点击菜单项时触发的函数
function changeContent(id) {
    var contents = document.getElementsByClassName('content'); // 获取所有content元素
    for (var i = 0; i < contents.length; i++) {
        contents[i].style.display = 'none'; // 隐藏所有content元素
    }
    var content = document.getElementById(id); // 获取对应ID的content元素
    content.style.display = 'flex'; // 显示当前content元素
}


// 给每个搜索按钮添加事件监听器
$(document).ready(function() {
    $(".search-input").on("input", function() {
        var searchText = $(this).val().toLowerCase();
        var contentDivs = $(".content");

        // 遍历所有的 content div
        contentDivs.each(function() {
            var infoContainers = $(this).find(".info-container");

            // 遍历当前 content div 中的 info-container
            infoContainers.each(function() {
                var infoText = $(this).text().toLowerCase();

                // 判断搜索文本是否匹配
                if (infoText.indexOf(searchText) !== -1) {
                    $(this).show();  // 显示匹配的 info-container
                } else {
                    $(this).hide();  // 隐藏不匹配的 info-container
                }
            });
        });
    });

    // 清空搜索框和显示所有 info-container
    $(".btn").click(function() {
        $(".search-input").val("");
        $(".info-container").show();
    });
});
