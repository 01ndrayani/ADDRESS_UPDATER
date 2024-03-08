<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Address</title>
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
        <h1 style="text-align: center;">Edit Address</h1>
        <%
            String addressId = request.getParameter("addressId");

            if (addressId != null) {
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/address_db", "root", "Jk@191997");

                    PreparedStatement ps = con.prepareStatement("SELECT * FROM addresses WHERE id = ?");
                    ps.setString(1, addressId);
                    ResultSet rs = ps.executeQuery();

                    if (rs.next()) {
                        String street = rs.getString("street");
                        String city = rs.getString("city");
                        String currentstate = rs.getString("state");
                        String zip = rs.getString("zip");
        %>
                        <form action="update.jsp" method="post">
                            <input type="hidden" name="action" value="Update">
                            <input type="hidden" name="addressId" value="<%= addressId %>">
                            
                            <label for="street">Street Address:</label>
                            <input type="text" id="street" name="street" value="<%= street %>" required>
                            
                            <label for="city">City:</label>
                            <input type="text" id="city" name="city" value="<%= city %>" required>
                            
                            <label for="state">State:</label>
                            <select id="state" name="state" required>
                        <option value="Andaman and Nicobar Islands" <%= currentstate %>>Andaman and Nicobar Island</option>
                <option value="Andhra Pradesh">Andhra Pradesh</option>
                <option value="Arunachal Pradesh">Arunachal Pradesh</option>
                <option value="Assam">Assam</option>
                <option value="Bihar">Bihar</option>
                <option value="Chandigarh">Chandigarh</option>
                <option value="Chhattisgarh">Chhattisgarh</option>
                <option value="Dadra and Nagar Haveli">Dadra and Nagar Haveli</option>
                <option value="Daman and Diu">Daman and Diu</option>
                <option value="Delhi">Delhi</option>
                <option value="Goa">Goa</option>
                <option value="Gujarat">Gujarat</option>
                <option value="Haryana">Haryana</option>
                <option value="Himachal Pradesh">Himachal Pradesh</option>
                <option value="Jammu and Kashmir">Jammu and Kashmir</option>
                <option value="Jharkhand">Jharkhand</option>
                <option value="Karnataka">Karnataka</option>
                <option value="Kerala">Kerala</option>
                <option value="Ladakh">Ladakh</option>
                <option value="Lakshadweep">Lakshadweep</option>
                <option value="Madhya Pradesh">Madhya Pradesh</option>
                <option value="Maharashtra">Maharashtra</option>
                <option value="Manipur">Manipur</option>
                <option value="Meghalaya">Meghalaya</option>
                <option value="Mizoram">Mizoram</option>
                <option value="Nagaland">Nagaland</option>
                <option value="Odisha">Odisha</option>
                <option value="Puducherry">Puducherry</option>
                <option value="Punjab">Punjab</option>
                <option value="Rajasthan">Rajasthan</option>
                <option value="Sikkim">Sikkim</option>
                <option value="Tamil Nadu">Tamil Nadu</option>
                <option value="Telangana">Telangana</option>
                <option value="Tripura">Tripura</option>
                <option value="Uttar Pradesh">Uttar Pradesh</option>
                <option value="Uttarakhand">Uttarakhand</option>
                <option value="West Bengal">West Bengal</option>
                            </select>
                            
                            <label for="zip">Zip Code:</label>
                            <input type="text" id="zip" name="zip" value="<%= zip %>" pattern="[0-9]{6}" required>
                            
                            <input type="submit" value="Update">
                        </form>
        <%
                    } else {
                        out.println("<p style='color: red;'>Address not found</p>");
                    }

                    con.close();
                } catch (Exception e) {
                    out.println("<p style='color: red;'>An error occurred: " + e.getMessage() + "</p>");
                }
            } else {
                out.println("<p style='color: red;'>Address ID not provided</p>");
            }
        %>
    </div>
</body>
</html>
