<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Address</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        .container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }

        form {
            margin-top: 20px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        input[type="text"],
        select {
            width: calc(100% - 40px);
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        input[type="submit"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
            display: inline-block;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 style="text-align: center;">Update Address</h1>
        <%
            String action = request.getParameter("action");

            if ("Update".equals(action)) {
                Connection con = null;
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/address_db", "root", "Jk@191997");

                    String addressId = request.getParameter("addressId");
                    String street = request.getParameter("street");
                    String city = request.getParameter("city");
                    String state = request.getParameter("state");
                    String zip = request.getParameter("zip");

                    PreparedStatement ps = con.prepareStatement("UPDATE addresses SET street = ?, city = ?, state = ?, zip = ? WHERE id = ?");
                    ps.setString(1, street);
                    ps.setString(2, city);
                    ps.setString(3, state);
                    ps.setString(4, zip);
                    ps.setString(5, addressId);
                    ps.executeUpdate();
        %>
                    <p style='color: green;'>Data updated successfully.</p>
        <%
                } catch (ClassNotFoundException | SQLException e) {
                    out.println("<p style='color: red;'>An error occurred: " + e.getMessage() + "</p>");
                } finally {
                    try {
                        if (con != null) {
                            con.close();
                        }
                    } catch (SQLException e) {
                        out.println("<p style='color: red;'>Error closing database connection: " + e.getMessage() + "</p>");
                    }
                }
            } else {
                out.println("<p style='color: red;'>Invalid action</p>");
            }
        %>
    </div>
</body>
</html>
