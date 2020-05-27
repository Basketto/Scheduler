using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using Scheduler.Views;
using System.Web.UI.WebControls;

namespace Scheduler.Models
{
    public class CalendarModel
    {
        protected List<Rooms> _rooms;
        protected aspnet_Users _user;

        public List<Rooms> Rooms
        {
            get
            {
                return this._rooms;
            }
        }
        public aspnet_Users User
        {
            get
            {
                return this._user;
            }
        }
        
        public CalendarModel(aspnet_Users usr, List<Rooms>  rooms)
        {
            this._rooms = rooms;
            if (usr == null)
                this._user = new aspnet_Users();
            else
                this._user = usr;
        }
    }
    
}