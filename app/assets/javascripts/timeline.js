/// <reference path="jquery.js" />
(function () {

    var months = ["January", "February", "March", "April", "May", "June", "July", "August",
        "September", "October", "November", "December"];

    window.Timeline = window.Timeline || {};

    Timeline.buildTimeline = function () {
        var container = $(".timeline");

        // Fill with realll data
        var context = createNewTimelineContext(container),
            month = -1,
            datas = Timeline.currentData;
        for (var i = 0; i < datas.length; i++) {
            var data = datas[i];
            data.date = new Date(data.start);
            data.evIndex = i;

            // Add a separator if necessary
            if (i !== 0) {
                if (month === data.date.getMonth()) {
                    context.leftHeight = context.left.innerHeight();
                    context.rightHeight = context.right.innerHeight();
                } else {
                    // Even out heights now
                    var height = Math.max(context.left.innerHeight(), context.right.innerHeight());
                    context.left.height(height);
                    context.right.height(height);

                    month = data.date.getMonth();

                    var sep = getSeparatorItem({ title: months[month] });
                    sep.appendTo(container);

                    context = createNewTimelineContext(container);
                }
            } else {
                month = data.date.getMonth();
            }

            // Add the item
            data.context = context;
            if (context.leftHeight > context.rightHeight) {
                data.left = false;
                data.el = getItem(data);
                data.el.appendTo(context.right);
            }
            else {
                data.left = true;
                data.el = getItem(data);
                data.el.appendTo(context.left);
            }
        }
    };

    var createNewTimelineContext = function (container) {
        var obj = $('<div class="row"> \
                     <div class="span4 tl-leftcol"></div> \
                     <div class="span4 tl-rightcol"></div> \
                 </div>');
        obj.appendTo(container);
        return {
            left: $(".tl-leftcol", obj),
            right: $(".tl-rightcol", obj),
            leftHeight: 0,
            rightHeight: 0,
            days: 30
        };
    };

    var beakHtml = '<div class="span1"><div class="tl-item-beak"></div><div class="tl-item-beakcover"></div></div>';
    var getItem = function (options) {
        var html = '<div class="tl-item row-fluid">';
        var i = options.evIndex;

        if (!options.left) {
            html += beakHtml;
        }

        var titleLink = Timeline.links[i],
            skillsStrip = Timeline.badgeHtmls[i],
            shareStrip = Timeline.shareHtmls[i],
            date = options.date,
            dateString = months[date.getMonth()] + " " + date.getDate() + ", " + date.getYear();
        html += '<div class="span11"> \
                    <div class="tl-item-contents"> \
                        ' + titleLink + ' <br /> \
                        ' + dateString + '<br /> \
                        ' + skillsStrip + '<br /> \
                        ' + options.description + ' \
                        ' + shareStrip + ' \
                    </div> \
                </div>';

        if (options.left) {
            html += beakHtml;
        }

        html += '</div>';

        return $(html);
    };

    var getSeparatorItem = function (options) {
        return $('<div class="row tl-separator"> \
                <div class="span3 tl-separator-line"></div> \
                <div class="span2 tl-separator-title"><h4>' + options.title + '</h4></div> \
                <div class="span3 tl-separator-line"></div> \
            </div>');
    };

})();