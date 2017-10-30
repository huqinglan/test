using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace JqueryApp.Models
{
    [Serializable]
    public class category
    {
        public category()
        { }
        #region Model

        public int id
        {
            set;
            get;
        }
        public int parent_id
        {
            set;
            get;
        }
        public string title
        {
            set;
            get;
        }
        public string status
        {
            set;
            get;
        }
        public string kind
        {
            set;
            get;
        }
        public string path
        {
            set;
            get;
        }
  
        #endregion Model
    }
}
