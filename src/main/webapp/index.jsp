<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Address Updater</title>
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
            margin-left: 30px;
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

        input[type="submit"],
        .show-all-button {
            width: calc(100% - 40px); /* Adjust the width based on your preference */
            padding: 10px;
            margin-right: 10px; /* Add some margin between buttons */
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
            
        }

 input[type="submit"],
        .edit-delete-buttons input[type="button"]
         {
          background-color:#38598b;
            color: white;
            width: calc(33% - 15px); /* Adjust the width based on your preference */
            padding: 10px;
            margin-right: 1px; /* Add some margin between buttons */
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
            display: inline-block;
             justify-content:space-between;
             
        }
        .spacer {
        height: 20px; /* Adjust this value to change the spacing */
    }

        input[type="submit"]:hover,
        .edit-delete-buttons input[type="button"]:hover,
        .show-all-button:hover {
            background-color:  #393e46;
        }

        .edit-delete-buttons input[type="button"],
        .show-all-button {
            background-color:#38598b;
            color: white;
           
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 style="text-align: center;">Address Updater</h1>
        <%
            String action = request.getParameter("action");
            if (action != null) {
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/address_db", "root", "Jk@191997");

                    if (action.equals("Add Address")) {
                        String street = request.getParameter("street");
                        String city = request.getParameter("city");
                        String state = request.getParameter("state");
                        String zip = request.getParameter("zip");

                        PreparedStatement ps = con.prepareStatement("INSERT INTO addresses (street, city, state, zip) VALUES (?, ?, ?, ?)");
                        ps.setString(1, street);
                        ps.setString(2, city);
                        ps.setString(3, state);
                        ps.setString(4, zip);
                        ps.executeUpdate();
                        out.println("<p style='color: green;'>Data inserted successfully.</p>");
                    } else if (action.equals("Edit")) {
                        String addressId = request.getParameter("addressId");
                        PreparedStatement ps = con.prepareStatement("SELECT * FROM addresses WHERE id = ?");
                        ps.setString(1, addressId);
                        ResultSet rs = ps.executeQuery();
                        if (rs.next()) {
                            String street = rs.getString("street");
                            String city = rs.getString("city");
                            String state = rs.getString("state");
                            String zip = rs.getString("zip");
                           
                           // Strin g street = "YourStreetValue"; Replace with the actual value
                            request.setAttribute("street", street);
                            request.setAttribute("city", city);
                            request.setAttribute("state", state);
                            request.setAttribute("zip", zip);
    
                        }
                    } else if (action.equals("Update")) {
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
                        out.println("<p style='color: green;'>Data updated successfully.</p>");
                    } else if (action.equals("Delete")) {
                        String addressId = request.getParameter("addressId");
                        PreparedStatement ps = con.prepareStatement("DELETE FROM addresses WHERE id = ?");
                        ps.setString(1, addressId);
                        ps.executeUpdate();
                        out.println("<p style='color: red;'>Data deleted successfully.</p>");
                    }
                    con.close();
                } catch (Exception e) {
                    out.println("<p style='color: red;'>An error occurred: " + e.getMessage() + "</p>");
                }
            }
        %>
        <form action="" method="post">
            <label for="street">Street Address:</label>
            <input type="text" id="street" name="street" required>
            
            <label for="city">City:</label>
            <input type="text" id="city" name="city" required>
            
           <label for="state">State:</label>
            <select id="state" name="state" required>
                <option value="">Select State</option>
                <option value="Andaman and Nicobar Islands">Andaman and Nicobar
Islands</option>
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
                            <input type="text" id="zip" name="zip" pattern="[0-9]{6}" required>
                            
      <div class="edit-delete-buttons">
            <input type="submit" value="Add Address" name="action">
           
                <input type="button" value="Edit" name="action" onclick="showEditForm()">
          
                <input type="button" value="Delete" name="action" onclick="showDeleteForm()">
            </div>
            <div class="spacer"></div>
            <input type="button" class="show-all-button" value="Show All" onclick="showAllAddresses()">
        </form>
        <script>
       
        function showEditForm() {
            var addressId = prompt("Please enter the address ID:");
            if (addressId) {
                // Redirect to the editAddress.jsp page with the specified addressId
                window.location.href = "edit.jsp?addressId=" + addressId;
            }
        }
        function showAllAddresses() {
            // Redirect to the show.jsp page for displaying all addresses
            window.location.href = "show.jsp";
        }

        function showDeleteForm() {
            var addressId = prompt("Please enter the address ID:");
            if (addressId) {
                if (confirm("Are you sure you want to delete this address?")) {
                    window.location.href = "?action=Delete&addressId=" + addressId;
                }
            }
        }
    </script>        
    </div>
</body>
</html>
