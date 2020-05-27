<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" ContentType="text/xml" %>
<data>
    <% foreach (var myevent in Model) { %>
        <event id="<%=myevent.id%>" textColor=
          "<%= (myevent.start_date < DateTime.Now ? 
          "gray" : myevent.aspnet_Users.color) %>">
            <start_date><![CDATA[<%=    String.Format("{0:dd/MM/yyyy HH:mm}",
                  myevent.start_date) %>]]></start_date>
            <end_date><![CDATA[<%=      String.Format("{0:dd/MM/yyyy HH:mm}",
                  myevent.end_date) %>]]></end_date>
            <text><![CDATA[<%=         Html.Encode(myevent.text)%>]]></text>
            <room_id><![CDATA[<%=  myevent.room_id %>]]></room_id>
            <username><![CDATA[<%= myevent.username  %>]]></username>
        </event>
    <% } %>
</data>