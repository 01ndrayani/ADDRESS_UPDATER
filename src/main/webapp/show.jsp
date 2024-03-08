<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Addresses</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        .container {
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 style="text-align: center;">All Addresses</h1>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Street</th>
                    <th>City</th>
                    <th>State</th>
                    <th>Zip</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/address_db", "root", "Jk@191997");

                        Statement statement = con.createStatement();
                        ResultSet rs = statement.executeQuery("SELECT * FROM addresses");

                        while (rs.next()) {
                            String id = rs.getString("id");
                            String street = rs.getString("street");
                            String city = rs.getString("city");
                            String state = rs.getString("state");
                            String zip = rs.getString("zip");
                %>
                            <tr>
                                <td><%= id %></td>
                                <td><%= street %></td>
                                <td><%= city %></td>
                                <td><%= state %></td>
                                <td><%= zip %></td>
                            </tr>
                <%
                        }
                        con.close();
                    } catch (Exception e) {
                        out.println("<p style='color: red;'>An error occurred: " + e.getMessage() + "</p>");
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
