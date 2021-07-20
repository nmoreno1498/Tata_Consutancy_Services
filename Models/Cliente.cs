using System;
using System.Collections.Generic;


namespace Tata_Consutancy_Services.Models
{
    public partial class Cliente
    {
        public Cliente()
        {
            PedidosExteriors = new HashSet<PedidosExterior>();
            PedidosInteriors = new HashSet<PedidosInterior>();
        }

        public int Id { get; set; }
        public string Nombre { get; set; }
        public string Desc { get; set; }
        public int? IsActive { get; set; }

        public virtual ICollection<PedidosExterior> PedidosExteriors { get; set; }
        public virtual ICollection<PedidosInterior> PedidosInteriors { get; set; }
    }
}
