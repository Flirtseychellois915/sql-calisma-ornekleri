# 🔌 Connecting Databases to Projects (Backend Integration)

We've learned how to write SQL queries, but how do we use this data in a real website or desktop application?

Here are the templates for connecting to our Northwind database using two of the most widely used languages ​​in the industry (C# and JavaScript):

## 1. Connecting to SQL Server with C# (.NET)
In the C# world, the `System.Data.SqlClient` library is generally used to connect to a database.
-
# 🔌 Veritabanını Projelere Bağlamak (Backend Entegrasyonu)

SQL sorgularını yazmayı öğrendik, peki bu verileri gerçek bir web sitesinde veya masaüstü uygulamasında nasıl kullanacağız? 

İşte sektörde en çok kullanılan iki dil (C# ve JavaScript) ile Northwind veritabanımıza bağlanma şablonları:

## 1. C# (.NET) ile SQL Server Bağlantısı
C# dünyasında veritabanına bağlanmak için genellikle `System.Data.SqlClient` kütüphanesi kullanılır.

```csharp
using System;
using System.Data.SqlClient;

class Program
{
    static void Main()
    {
        // 1. Adım: Bağlantı adresini (Connection String) tanımla
        string connectionString = "Server=SENIN_SUNUCU_ADIN;Database=Northwind;Trusted_Connection=True;";

        // 2. Adım: Bağlantıyı aç ve sorguyu gönder
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            connection.Open();
            string sqlSorgusu = "SELECT TOP 5 ProductName, UnitPrice FROM Products";
            
            using (SqlCommand command = new SqlCommand(sqlSorgusu, connection))
            {
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    Console.WriteLine("--- En Pahalı 5 Ürün ---");
                    while (reader.Read())
                    {
                        // 3. Adım: Gelen veriyi ekrana yazdır
                        Console.WriteLine($"{reader["ProductName"]} - {reader["UnitPrice"]:C2}");
                    }
                }
            }
        }
    }
}
