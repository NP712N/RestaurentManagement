﻿using CoffeeManager.DAO;
using CoffeeManager.DTO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CoffeeManager.DAO
{
    public class BillDAO // lấy bill từ IDTable
    {
        private static BillDAO instance;

        public static BillDAO Instance
        {
            get { if (instance == null) instance = new BillDAO(); return BillDAO.instance; }
            private set { BillDAO.instance = value; }
        }

        private BillDAO() { }

        public int GetUncheckBillIDByTableID(int id)// lấy id của bill
        {
            DataTable data = DataProvider.Instance.ExecuteQuery("SELECT * FROM Bill WHERE idTable = " + id + " AND status = 0");

            if (data.Rows.Count > 0)
            {
                Bill bill = new Bill(data.Rows[0]);
                return bill.ID;
            }
            return -1;
        }

        public void InsertBill(int id)
        {
            DataProvider.Instance.ExecuteNonQuery("exec USP_InsertBill @idTable",new object[] { id });
        }

        public int GetMaxIDBill()
        {
            try { return (int)DataProvider.Instance.ExecuteScalar("SELECT MAX(id) FROM Bill"); }
            catch { return 1; }
        }

        public DataTable GetBillListByDate(DateTime checkIn,DateTime checkOut)
        {
          return  DataProvider.Instance.ExecuteQuery("exec USP_GetListBillByDate @checkIn , @checkOut",new object[] { checkIn, checkOut});
        }
        public void CheckOut(int id,int discount,float totalPrice)
        {
            string query = "Update Bill Set DateCheckOut = Getdate(), status = 1, " +"discount = "+discount +", totalPrice = "+totalPrice+ " where id = "+id;
            DataProvider.Instance.ExecuteNonQuery(query);
        }
    }
}