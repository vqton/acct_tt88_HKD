using Microsoft.EntityFrameworkCore;
using HkdAccounting.Application.Services;
using HkdAccounting.Domain.Repositories;
using HkdAccounting.Infrastructure.Data;
using HkdAccounting.Infrastructure.Repositories;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllersWithViews();

// Database context
builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseSqlite(builder.Configuration.GetConnectionString("DefaultConnection")));

// Register repositories
builder.Services.AddScoped<INhanVienRepository, NhanVienRepository>();
builder.Services.AddScoped<ITaiKhoanNganHangRepository, TaiKhoanNganHangRepository>();

// Register application services
builder.Services.AddScoped<INhanVienService, NhanVienService>();
builder.Services.AddScoped<ITaiKhoanNganHangService, TaiKhoanNganHangService>();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseRouting();

app.UseAuthorization();

app.MapStaticAssets();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}")
    .WithStaticAssets();


app.Run();
