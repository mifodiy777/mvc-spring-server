<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<security:authorize access="hasRole('ROLE_ADMIN')" var="isAdmin"/>
<security:authentication property="principal" var="user"/>
<jsp:include page="header.jsp"/>
<script type="text/javascript">

    $(document).ready(function () {

        $('#studentTable').DataTable({
            "ajax": "allStudents",
            "columns": [
                {
                    "render": function (data, type, full) {
                        return '<a href=\"#\" onclick=\"editEntity(' + full.id + ')\"><c:if test="${isAdmin}">Редактировать</c:if><c:if test="${!isAdmin}">Просмотр</c:if></a>'
                    }, "searchable": false, "orderable": false
                },
                {"data": "surname", 'title': 'Фамилия'},
                {"data": "name", 'title': 'Имя'},
                {"data": "gender", 'title': 'Пол'},
                {"data": "birthday", 'title': 'Дата рождения'}
                <c:if test="${isAdmin}">
                , {
                    "render": function (data, type, full) {
                        return '<a href=\"#\" class="text-danger" onclick=\"deleteStudent(' + full.id + ')\">Удалить</a>'
                    }, "searchable": false, "orderable": false
                }
                </c:if>

            ]
        });

    });

</script>
<div class="container">
    <c:if test="${isAdmin}">
        <button class="btn btn-success addBtn" onclick="saveEntity('student')">
            <span class="glyphicon glyphicon-plus"></span> Добавить студента
        </button>
    </c:if>
    <div id="formPanel"></div>
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h4>Список студентов</h4>
        </div>
        <br>

        <div class="panel-body">
            <table id="studentTable" class="table table-striped table-bordered" cellspacing="0" width="100%"></table>
        </div>
    </div>

</div>
<jsp:include page="footer.jsp"/>
