	<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<html xmlns="http://www.w3.org/1999/xhtml" >
	<head id="Head1" runat="server">
	    <title>Index</title>
	    <script src="/Scripts/dhtmlxscheduler.js" type="text/javascript"></script>
        <script src="/Scripts/ext/dhtmlxscheduler_units.js" type="text/javascript"></script>
        <script src="/Scripts/ext/dhtmlxscheduler_week_agenda.js" type="text/javascript"></script>
	    <link href="/Scripts/dhtmlxscheduler.css" rel="stylesheet" type="text/css" />
	    <style type="text/css">
	        html, body
	        {
	            height:100%;
	            padding:0px;
	            margin:0px;
	        }
	    </style>
	    <script type="text/javascript">
            function init() {
                
    //stores the name of the user in js var
   //stores the name of the user in js var
    <% if(Request.IsAuthenticated){ %>
                scheduler._user_id = "<%= Model.User.UserId %>";
                scheduler._color = "<%= Model.User.color %>";
    <%} %>
                //blocks all operations for non-authenticated users
                scheduler.config.readonly =
      <%= Request.IsAuthenticated ? "false" : "true" %>;

                    //stores the name of the user in js var
    <% if(Request.IsAuthenticated){ %>
                scheduler._user_id = "<%= Model.User.UserId %>";
                scheduler._color = "<%= Model.User.color %>";
    <%} %>
                //blocks all operations for non-authenticated users
                scheduler.config.readonly =
      <%= Request.IsAuthenticated ? "false" : "true" %>;
   //stores the name of the user in js var
    <% if(Request.IsAuthenticated){ %>
                scheduler._user_id = "<%= Model.User.UserId %>";
                scheduler._color = "<%= Model.User.color %>";
    <%} %>
                //blocks all operations for non-authenticated users
                scheduler.config.readonly =
      <%= Request.IsAuthenticated ? "false" : "true" %>;
		//store name of user in js var
		        <% if(Request.IsAuthenticated){ %>
                scheduler._user_id = "<%= Model.User.UserId %>";
                scheduler._color = "<%= Model.User.color %>";
		        <%} %>
                //block all operations for not authenticated user
                scheduler.config.readonly = <%= Request.IsAuthenticated ? "false" : "true" %>;

                //visual settings
                scheduler.config.first_hour = 8;
                scheduler.config.last_hour = 18;
                scheduler.locale.labels.units_tab = 'Rooms';
                scheduler.locale.labels.section_room = "Room:";
                scheduler.config.multi_day = true;

                //custom event text
                function template(start, end, ev) {
                    return getRoom(ev.room_id) + " : " + ev.text;
                }
                scheduler.templates.event_text = template;
                scheduler.templates.agenda_text = template;
                scheduler.templates.event_bar_text = template;
                scheduler.templates.week_agenda_event_text = function (start_date, end_date, event, date) {
                    return scheduler.templates.event_date(start_date) + " " + template(start_date, end_date, event);
                };

                //list of rooms
                var rooms = [<% for(var i =0; i < Model.Rooms.Count; i++){ %>
                    { key:<%= Model.Rooms[i].room_id %>, label:"<%= Html.Encode(Model.Rooms[i].title) %>" }<%= i<Model.Rooms.Count-1 ? "," : "" %>   
                <% } %>];
                //helper, returns room name by id
                function getRoom(id) {
                    for (var i in rooms) {
                        if (rooms[i].key == id)
                            return rooms[i].label;
                    }
                }

                //units view
                scheduler.createUnitsView({
                    "name": "units",
                    "list": rooms,
                    "property": "room_id"
                });

                //lightbox configuration
                scheduler.config.lightbox.sections = [
                    { name: "description", height: 200, map_to: "text", type: "textarea", focus: !0 },
                    { name: "room", map_to: "room_id", type: "select", options: rooms },
                    { name: "time", height: 72, type: "time", map_to: "auto" }
                ];


                //check is event belongs to the user and is it not started yet
                var isEditable = function (event_id) {
                    var ev = scheduler.getEvent(event_id);
                    return (ev && ev.start_date > new Date() && ev.user_id == scheduler._user_id);
                };
                //block operations for not owned events
                scheduler.attachEvent("onBeforeLightbox", isEditable);
                scheduler.attachEvent("onBeforeDrag", isEditable);
                scheduler.attachEvent("onClick", isEditable);
                scheduler.attachEvent("onDblClick", isEditable);
                //each time as new event created - assign user, color and room to it
                scheduler.attachEvent("onEventCreated", function (event_id) {
                    var ev = scheduler.getEvent(event_id);
                    if (ev.start_date < new Date()) {
                        scheduler.deleteEvent(event_id, true);
                    } else {
                        ev.user_id = scheduler._user_id;
                        ev.textColor = scheduler._color;
                        return true;
                    }
                });


                //data loading
                scheduler.config.xml_date = "%d/%m/%Y %H:%i";
                scheduler.init("scheduler_here", new Date(2011, 8, 9), "month");
                scheduler.load("/Calendar/Data");
                //data saving
                var dp = new dataProcessor("/Calendar/Save");
                dp.init(scheduler);
                dp.setTransactionMode("POST", false);
            }
	    </script>
	</head>
	<body onload="init()">
		<div id="scheduler_here" class="dhx_cal_container" style='width:100%; height:100%;'>
			<div class="dhx_cal_navline">
				<div class="dhx_cal_prev_button">&nbsp;</div>
				<div class="dhx_cal_next_button">&nbsp;</div>
				<div class="dhx_cal_today_button"></div>
				<div class="dhx_cal_date"></div>
                <div class="dhx_cal_tab" name="week_agenda_tab" style="right:278px;"></div>
                <div class="dhx_cal_tab" name="units_tab" style="right:214px;"></div>
				<div class="dhx_cal_tab" name="week_tab" style="right:140px;"></div>
				<div class="dhx_cal_tab" name="month_tab" style="right:76px;"></div>
                <div class="" style="right:420px;height:23px;"> <% Html.RenderPartial("LogOnUserControl"); %></div>
			</div>
			<div class="dhx_cal_header">
			</div>
			<div class="dhx_cal_data">
			</div>		
		</div>
	</body>
	</html>