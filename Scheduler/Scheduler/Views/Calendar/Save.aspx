<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<Scheduler.Controllers.CalendarActionResponseModel>" ContentType="text/xml"%>
<data>
    <action type="<%= Model.Status %>" sid="<%= Model.Source_id %>" tid="<%= Model.Target_id %>"></action>
</data>