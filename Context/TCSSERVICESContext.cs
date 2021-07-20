using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;
using Tata_Consutancy_Services.Models;

namespace Tata_Consutancy_Services.Context
{
    public partial class TCSSERVICESContext : DbContext
    {
        public TCSSERVICESContext()
        {
        }

        public TCSSERVICESContext(DbContextOptions<TCSSERVICESContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Cliente> Clientes { get; set; }
        public virtual DbSet<PedidosExterior> PedidosExteriors { get; set; }
        public virtual DbSet<PedidosInterior> PedidosInteriors { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasAnnotation("Relational:Collation", "Modern_Spanish_CI_AS");

            modelBuilder.Entity<Cliente>(entity =>
            {
                entity.ToTable("Cliente");

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.Desc).HasMaxLength(20);

                entity.Property(e => e.IsActive).HasColumnName("is_active");

                entity.Property(e => e.Nombre).HasMaxLength(15);
            });

            modelBuilder.Entity<PedidosExterior>(entity =>
            {
                entity.ToTable("Pedidos_Exterior");

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.ClienteId).HasColumnName("Cliente_ID");

                entity.Property(e => e.Desc).HasMaxLength(20);

                entity.HasOne(d => d.Cliente)
                    .WithMany(p => p.PedidosExteriors)
                    .HasForeignKey(d => d.ClienteId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("fk_cliente_ext");
            });

            modelBuilder.Entity<PedidosInterior>(entity =>
            {
                entity.ToTable("Pedidos_Interior");

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.ClienteId).HasColumnName("Cliente_ID");

                entity.Property(e => e.Desc).HasMaxLength(20);

                entity.HasOne(d => d.Cliente)
                    .WithMany(p => p.PedidosInteriors)
                    .HasForeignKey(d => d.ClienteId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("fk_cliente_int");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
