using System;
using System.Collections.Generic;

namespace ApiSqlServer.Models;

public partial class TipoDeTransaccion
{
    public int Id { get; set; }

    public string TipoTrasaccion { get; set; } = null!;

    public virtual ICollection<Transaccione> Transacciones { get; set; } = new List<Transaccione>();
}
