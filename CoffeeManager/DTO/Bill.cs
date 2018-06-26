using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CoffeeManager.DTO
{
    public class Bill
    {
        private int discount;
        int iD;

        private int status;
        DateTime? dateCheckOut;
        DateTime? dateCheckIn; // kiểu dữ liệu có thể null 
        public Bill(int id, DateTime? dateCheckin, DateTime? dateCheckOut, int status,int discount =0)
        {
            this.ID = id;
            this.DateCheckOut = dateCheckOut;
            this.DateCheckIn = dateCheckin;
            this.Status = status;
            this.Discount = discount;
        }

        public Bill(DataRow row)
        {
            this.ID = (int)row["id"];
            var dateCheckOutTemp = row["dateCheckOut"]; 
            if (dateCheckOutTemp.ToString() != "")
                this.DateCheckOut = (DateTime?)row["dateCheckOut"];           
            this.DateCheckIn = (DateTime?)row["dateCheckin"];
            this.Status = (int)row["status"];

            if(row["discount"].ToString()!="")
            this.Discount = (int)row["discount"];
        }

        public int ID { get => iD; set => iD = value; }
        public DateTime? DateCheckIn { get => dateCheckIn; set => dateCheckIn = value; }
        public DateTime? DateCheckOut { get => dateCheckOut; set => dateCheckOut = value; }
        public int Status { get => status; set => status = value; }
        public int Discount { get => discount; set => discount = value; }
    }
}
