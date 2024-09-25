<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>City Wise Areas</title>
    <style>
        body {
            background-color: black;
            color: white;
        }
        .boxx {
            margin-left: 400px;
            margin-right: 100px;
             border-radius: 10px; /* Rounded corners for modern look */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-top:20px;
            padding:10px;
        }
        .boxx h3{
        margin-top:30px;}
        table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid #ddd;
            text-align: center;
        }
        thead th {
            background-color: #333;
            color: white;
        }
        tbody tr:nth-child(odd) {
            background-color: #f2f2f2;
        }
        tbody tr:nth-child(even) {
            background-color: #ffffff;
        }
        tbody tr:hover {
            background-color: #ddd;
        }
        .btn {
            margin: 5px;
        }
    </style>
    
    <!-- DataTables CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.24/css/jquery.dataTables.min.css"/>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" crossorigin="anonymous">
    <!-- DataTables JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>
    <!-- Bootstrap JS -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" crossorigin="anonymous"></script>
    
    <script>
        $(document).ready(function () {
            $('#cityTable').DataTable(); // Initialize DataTables for dynamic tables
        });

        // Function to confirm deletion
        function confirmDeletion(hotelid) {
            $('#confirmDeleteModal').data('hotel-id', hotelid).modal('show');
        }

        // Handle delete confirmation
        function deleteHotel() {
            const hotelid = $('#confirmDeleteModal').data('hotel-id');
            window.location.href = 'deleteHotelbyHid?hotelid=' + hotelid;
        }
    </script>
</head>
<body>
    <jsp:include page="adminpro.jsp"></jsp:include>

    <div class="boxx">
        <h3 class="text-center">All City Wise Areas</h3>
        
        <!-- Form to handle city and area selection -->
        <form action="${pageContext.request.contextPath}/viewhotel" method="GET">
            <div class="form-group">
                <!-- City Dropdown -->
                <select name="id" class="form-control" onchange="this.form.submit()" required>
                    <option value="">Select City</option>
                    <c:forEach var="e" items="${clist}">
                        <option value="${e.id}" ${e.id == param.id ? 'selected' : ''}>${e.cname}</option>
                    </c:forEach>
                </select>
                <br>

                <!-- Area Dropdown, populated based on selected city -->
                <select name="aid" class="form-control" onchange="this.form.submit()" required>
                    <option value="">Select Area</option>
                    <c:forEach var="area" items="${alist}">
                        <option value="${area.aid}" ${area.aid == param.aid ? 'selected' : ''}>${area.aname}</option>
                    </c:forEach>
                </select>
                <br>
            </div>
        </form>
        
        <!-- Display the hotel list -->
        <div id="gridShow">
        
            <table id="cityTable" class="table table-striped table-bordered">
            
                       
                <thead>
               
                    <tr>
                        <th>ID</th>
                        <th>Hotel Name</th>
                        <th>Hotel Address</th>
                        <th>Hotel Rating</th>
                        <th>Hotel Reviews</th>
                    
                        <th>DELETE</th>
                        <th>UPDATE</th>
                    </tr>
                </thead>
                <tbody id="hotelList">
                <%int count=0;
                %>
                    <c:forEach var="hotel" items="${hlist}">
                    <%++count; %>
                        <tr id="hotel-${hotel.getHotelid()}">
                            <th scope="row"><%=count %></th>
                            <td>${hotel.hotelName}</td>
                            <td>${hotel.hotelAddress}</td>
                            <td>${hotel.rating}</td>
                            <td>${hotel.reviews}</td>
                          
                            <td><button class="btn btn-danger" onclick="confirmDeletion(${hotel.hotelid})">Delete</button></td>
                            <td> <a href="updatehotelbyid?hotelid=${hotel.hotelid}" class="btn btn-primary btn-sm">Edit</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="confirmDeleteModal" tabindex="-1" role="dialog" aria-labelledby="confirmDeleteModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="confirmDeleteModalLabel">Confirm Deletion</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    Are you sure you want to delete this hotel?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-danger" onclick="deleteHotel()">Delete</button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
