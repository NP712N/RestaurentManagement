﻿using CoffeeManager.DTO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CoffeeManager.DAO
{
   public class AccountDAO
    {
        static AccountDAO instance;
        public static AccountDAO Instance
        {
            get { if (instance == null) instance = new AccountDAO(); return instance; }
            private set { instance = value; }
        }

         AccountDAO() { }

        public bool Login(string userName, string passWord) // sử dụng stored procedure fix lỗi SQL Injection (lỗi vượt qua bảo mật)
        {
            string query = "USP_Login @userName , @passWord";// phải có khoảng trắng _,_

            DataTable result = DataProvider.Instance.ExecuteQuery(query, new object[] { userName,passWord}); 
            return result.Rows.Count > 0 ;
        }
        public Account GetAccountByUserName(string userName)
        {
            DataTable data = DataProvider.Instance.ExecuteQuery("Select * from account where userName = '" + userName + "'");

            foreach (DataRow item in data.Rows)
            {
                return new Account(item);
            }

            return null;
        }
        public bool UpdateAccount(string userName, string displayName, string pass, string newPass)
        {
            int result = DataProvider.Instance.ExecuteNonQuery("exec USP_UpdateAccount @userName , @displayName , @password , @newPassword", new object[] { userName, displayName, pass, newPass });

            return result > 0;
        }
        public DataTable GetListAccount()// hiển thị danh sách tài khoản
        {
            return DataProvider.Instance.ExecuteQuery("SELECT UserName, DisplayName, Type FROM dbo.Account");
        }
    }
}
