//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Powerfront.Backend.Impact.EntityFramework
{
    using System;
    using System.Collections.Generic;
    
    public partial class ImpactBeneficiary
    {
        public System.Guid id { get; set; }
        public System.Guid ImpactId { get; set; }
        public System.Guid BeneficiaryGroupId { get; set; }
    
        public virtual BeneficiaryGroup BeneficiaryGroup { get; set; }
        public virtual Impact Impact { get; set; }
    }
}
