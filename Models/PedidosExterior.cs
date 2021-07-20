using System;
using System.Collections.Generic;


namespace Tata_Consutancy_Services.Models
{
    public partial class PedidosExterior
    {
        public int Id { get; set; }
        public int ClienteId { get; set; }
        public string Desc { get; set; }
        public int? Estado { get; set; }

        public virtual Cliente Cliente { get; set; }
    }
}
