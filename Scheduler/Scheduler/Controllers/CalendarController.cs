using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Scheduler.Models;
using System.Web.Security;
namespace Scheduler.Controllers
{
    public class CalendarActionResponseModel
    {
        public String Status;
        public Int64 Source_id;
        public Int64 Target_id;

        public CalendarActionResponseModel(String status, Int64 source_id, Int64 target_id)
        {
            Status = status;
            Source_id = source_id;
            Target_id = target_id;
        }
    }


    public class CalendarController : Controller
    {

        public ActionResult Index()
        {
            MyEventsDataContext context = new MyEventsDataContext();

            aspnet_Users current_user = null;
            if (Request.IsAuthenticated)
                current_user = context.aspnet_Users.SingleOrDefault(user => user.UserId == (Guid)Membership.GetUser().ProviderUserKey);

            return View(new CalendarModel(current_user, context.Rooms.ToList()));
        }

        public ActionResult Data()
        {
            MyEventsDataContext data = new MyEventsDataContext();
            return View(data.Events);
        }




        public ActionResult Save(Events changedEvent, FormCollection actionValues)
        {
            String action_type = actionValues["!nativeeditor_status"];
            Int64 source_id = Int64.Parse(actionValues["id"]);
            Int64 target_id = source_id;

            if (Request.IsAuthenticated && changedEvent.user_id == (Guid)Membership.GetUser().ProviderUserKey && changedEvent.start_date > DateTime.Now)
            {
                MyEventsDataContext data = new MyEventsDataContext();
                try
                {
                    switch (action_type)
                    {
                        case "inserted":
                            data.Events.InsertOnSubmit(changedEvent);
                            break;
                        case "deleted":
                            changedEvent = data.Events.SingleOrDefault(ev => ev.id == source_id);
                            data.Events.DeleteOnSubmit(changedEvent);
                            break;
                        default: // "updated"                          
                            changedEvent = data.Events.SingleOrDefault(ev => ev.id == source_id);
                            TryUpdateModel(changedEvent);
                            break;
                    }
                    data.SubmitChanges();
                    target_id = changedEvent.id;
                }
                catch (Exception a)
                {
                    action_type = "error";
                }
            }
            else
            {
                action_type = "error";
            }
            return View(new CalendarActionResponseModel(action_type, source_id, target_id));
        }
    }
}
