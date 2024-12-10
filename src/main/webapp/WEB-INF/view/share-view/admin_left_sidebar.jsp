<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>

<aside class="left-sidebar">
    <!-- Sidebar scroll-->
    <div class="d-flex flex-column h-100">
        <div class="brand-logo d-flex align-items-center justify-content-between">
            <a href="./index.html" class="text-nowrap logo-img">
                <img src="/images/admin/logos/dark-logo.svg" width="180" alt="" />
            </a>
            <div class="close-btn d-xl-none d-block sidebartoggler cursor-pointer" id="sidebarCollapse">
                <i class="ti ti-x fs-8"></i>
            </div>
        </div>
        <!-- Sidebar navigation-->
        <nav class="sidebar-nav d-flex flex-column h-100" data-simplebar="">
            <ul id="sidebarnav">
                <li class="nav-small-cap">
                    <i class="ti ti-dots nav-small-cap-icon fs-4"></i>
                    <span class="hide-menu">Home</span>
                </li>
                <li class="sidebar-item">
                    <a class="sidebar-link" href="./#" aria-expanded="false">
                    <span>
                      <i class="ti ti-layout-dashboard"></i>
                    </span>
                        <span class="hide-menu">Dashboard</span>
                    </a>
                </li>
                <li class="sidebar-item">
                    <a class="sidebar-link" href="/admin/aircrafts" aria-expanded="false">
                    <span>
                      <i class="ti ti-article"></i>
                    </span>
                        <span class="hide-menu">Aircraft</span>
                    </a>
                </li>
                <li class="sidebar-item">
                    <a class="sidebar-link" href="/admin/users" aria-expanded="false">
                        <span>
                          <i class="ti ti-alert-circle"></i>
                        </span>
                        <span class="hide-menu">Customer</span>
                    </a>
                </li>
                <li class="sidebar-item">
                    <a class="sidebar-link" href="/admin/tickets" aria-expanded="false">
                    <span>
                      <i class="ti ti-cards"></i>
                    </span>
                        <span class="hide-menu">Ticket</span>
                    </a>
                </li>
                <li class="sidebar-item">
                    <a class="sidebar-link" href="/admin/announcements" aria-expanded="false">
                    <span>
                      <i class="ti ti-file-description"></i>
                    </span>
                        <span class="hide-menu">Content</span>
                    </a>
                </li>
                <li class="sidebar-item">
                    <a class="sidebar-link" href="/admin/promotions" aria-expanded="false">
                    <span>
                      <i class="ti ti-file-description"></i>
                    </span>
                        <span class="hide-menu">Promotion</span>
                    </a>
                </li>
                <li class="sidebar-item">
                    <a class="sidebar-link" href="/admin/flights" aria-expanded="false">
                    <span>
                      <i class="ti ti-typography"></i>
                    </span>
                        <span class="hide-menu">Flight</span>
                    </a>
                </li>
            </ul>

        </nav>
        <!-- End Sidebar navigation -->

        <li class="mt-auto mb-3">
            <div class="d-flex justify-content-center ">
                <button type="button" id="btn-logout" class="btn btn-outline-primary mx-3 mt-2 d-block">Logout</button>
            </div>
        </li>
    </div>
    <!-- End Sidebar scroll-->
</aside>

<script>
    $('#btn-logout').click(function() {
        $.ajax({
            url: '/admin/logout',
            method: 'POST',
            headers: {
                'Authorization': 'Bearer ' + localStorage.getItem('accessToken')  // Lấy token từ localStorage
            },
            success: function(response) {
                console.log(response);
                window.location.href='/admin/login';
            },
        })
        localStorage.clear();
    })
</script>