﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.18449
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace ServiceClient.ServiceReference1 {
    using System.Runtime.Serialization;
    using System;
    
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Runtime.Serialization", "4.0.0.0")]
    [System.Runtime.Serialization.DataContractAttribute(Name="TraziFondove_Result", Namespace="http://schemas.datacontract.org/2004/07/InvestApp.DAL", IsReference=true)]
    [System.SerializableAttribute()]
    public partial class TraziFondove_Result : ServiceClient.ServiceReference1.ComplexObject {
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private System.Nullable<int> CILJ_PRINOSA_IDField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private System.Nullable<System.DateTime> DATUM_OSNIVANJAField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string DODATNI_PODACIField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private System.Nullable<int> DRUSTVA_IDField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private int FAVORITField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private int IDField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private System.Nullable<decimal> IMOVINA_FONDAField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private System.Nullable<int> KATEGORIJA_IDField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string KIID_URLField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private System.Nullable<decimal> MINIMALNA_POCETNA_UPLATAField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private System.Nullable<decimal> MINIMALNE_OSTALE_UPLATEField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private System.Nullable<decimal> NAKNADA_BANKA_FIKSNAField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private System.Nullable<decimal> NAKNADA_BANKA_MAKSIMALNIField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private System.Nullable<decimal> NAKNADA_BANKA_MINIMALNIField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private System.Nullable<decimal> NAKNADA_BANKA_POSTOField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string NAKNADA_DEPOZITARNOJ_BANCIField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string NAKNADA_IZLAZNAField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string NAKNADA_ULAZNAField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string NAKNADA_ZA_UPRAVLJANJEM_FONDAField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string NALOG_OPIS_PLACANJAField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string NALOG_PBOField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string NALOG_PBO_MODELField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string NALOG_PRIMATELJ_RACUNField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string NALOG_PRIMATELJ_VBDIField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string NALOG_SIFRA_NAMJENEField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string NAPOMENA_ZA_KUPNJUField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string NAPOMENA_ZA_ODREGISTRACIJUField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string NAPOMENA_ZA_PRODAJUField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string NAPOMENA_ZA_REGISTRACIJUField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string NAZIVField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string NAZIV_KATEGORIJEField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string NAZIV_VLASNIKAField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string OSOBNA_ISKAZNICA_URLField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private System.Nullable<decimal> POCETNA_CIJENA_UDJELAField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string PRAVILA_URLField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private System.Nullable<int> PROFIL_RIZICNOSTI_IDField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private System.Nullable<decimal> PROSLA_VRIJEDNOSTField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string PROSPEKT_URLField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private System.Nullable<int> REGIJA_IDField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string RIZICNOSTField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private System.Nullable<int> SEKTOR_IDField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private System.Nullable<int> TIP_ULAGANJA_IDField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private System.Nullable<int> TIP_UPRAVLJANJA_IDField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private System.Nullable<int> TRZISTE_IDField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string VALUTAField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string VALUTA_SIFRAField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private System.Nullable<System.DateTime> VRIJEDI_DOField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private System.Nullable<System.DateTime> VRIJEDI_ODField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private System.Nullable<decimal> VRIJEDNOSTField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private System.Nullable<System.DateTime> VRIJEDNOST_DATUMField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string ZAHTJEV_REPORT_IDField;
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public System.Nullable<int> CILJ_PRINOSA_ID {
            get {
                return this.CILJ_PRINOSA_IDField;
            }
            set {
                if ((this.CILJ_PRINOSA_IDField.Equals(value) != true)) {
                    this.CILJ_PRINOSA_IDField = value;
                    this.RaisePropertyChanged("CILJ_PRINOSA_ID");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public System.Nullable<System.DateTime> DATUM_OSNIVANJA {
            get {
                return this.DATUM_OSNIVANJAField;
            }
            set {
                if ((this.DATUM_OSNIVANJAField.Equals(value) != true)) {
                    this.DATUM_OSNIVANJAField = value;
                    this.RaisePropertyChanged("DATUM_OSNIVANJA");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string DODATNI_PODACI {
            get {
                return this.DODATNI_PODACIField;
            }
            set {
                if ((object.ReferenceEquals(this.DODATNI_PODACIField, value) != true)) {
                    this.DODATNI_PODACIField = value;
                    this.RaisePropertyChanged("DODATNI_PODACI");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public System.Nullable<int> DRUSTVA_ID {
            get {
                return this.DRUSTVA_IDField;
            }
            set {
                if ((this.DRUSTVA_IDField.Equals(value) != true)) {
                    this.DRUSTVA_IDField = value;
                    this.RaisePropertyChanged("DRUSTVA_ID");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public int FAVORIT {
            get {
                return this.FAVORITField;
            }
            set {
                if ((this.FAVORITField.Equals(value) != true)) {
                    this.FAVORITField = value;
                    this.RaisePropertyChanged("FAVORIT");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public int ID {
            get {
                return this.IDField;
            }
            set {
                if ((this.IDField.Equals(value) != true)) {
                    this.IDField = value;
                    this.RaisePropertyChanged("ID");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public System.Nullable<decimal> IMOVINA_FONDA {
            get {
                return this.IMOVINA_FONDAField;
            }
            set {
                if ((this.IMOVINA_FONDAField.Equals(value) != true)) {
                    this.IMOVINA_FONDAField = value;
                    this.RaisePropertyChanged("IMOVINA_FONDA");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public System.Nullable<int> KATEGORIJA_ID {
            get {
                return this.KATEGORIJA_IDField;
            }
            set {
                if ((this.KATEGORIJA_IDField.Equals(value) != true)) {
                    this.KATEGORIJA_IDField = value;
                    this.RaisePropertyChanged("KATEGORIJA_ID");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string KIID_URL {
            get {
                return this.KIID_URLField;
            }
            set {
                if ((object.ReferenceEquals(this.KIID_URLField, value) != true)) {
                    this.KIID_URLField = value;
                    this.RaisePropertyChanged("KIID_URL");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public System.Nullable<decimal> MINIMALNA_POCETNA_UPLATA {
            get {
                return this.MINIMALNA_POCETNA_UPLATAField;
            }
            set {
                if ((this.MINIMALNA_POCETNA_UPLATAField.Equals(value) != true)) {
                    this.MINIMALNA_POCETNA_UPLATAField = value;
                    this.RaisePropertyChanged("MINIMALNA_POCETNA_UPLATA");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public System.Nullable<decimal> MINIMALNE_OSTALE_UPLATE {
            get {
                return this.MINIMALNE_OSTALE_UPLATEField;
            }
            set {
                if ((this.MINIMALNE_OSTALE_UPLATEField.Equals(value) != true)) {
                    this.MINIMALNE_OSTALE_UPLATEField = value;
                    this.RaisePropertyChanged("MINIMALNE_OSTALE_UPLATE");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public System.Nullable<decimal> NAKNADA_BANKA_FIKSNA {
            get {
                return this.NAKNADA_BANKA_FIKSNAField;
            }
            set {
                if ((this.NAKNADA_BANKA_FIKSNAField.Equals(value) != true)) {
                    this.NAKNADA_BANKA_FIKSNAField = value;
                    this.RaisePropertyChanged("NAKNADA_BANKA_FIKSNA");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public System.Nullable<decimal> NAKNADA_BANKA_MAKSIMALNI {
            get {
                return this.NAKNADA_BANKA_MAKSIMALNIField;
            }
            set {
                if ((this.NAKNADA_BANKA_MAKSIMALNIField.Equals(value) != true)) {
                    this.NAKNADA_BANKA_MAKSIMALNIField = value;
                    this.RaisePropertyChanged("NAKNADA_BANKA_MAKSIMALNI");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public System.Nullable<decimal> NAKNADA_BANKA_MINIMALNI {
            get {
                return this.NAKNADA_BANKA_MINIMALNIField;
            }
            set {
                if ((this.NAKNADA_BANKA_MINIMALNIField.Equals(value) != true)) {
                    this.NAKNADA_BANKA_MINIMALNIField = value;
                    this.RaisePropertyChanged("NAKNADA_BANKA_MINIMALNI");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public System.Nullable<decimal> NAKNADA_BANKA_POSTO {
            get {
                return this.NAKNADA_BANKA_POSTOField;
            }
            set {
                if ((this.NAKNADA_BANKA_POSTOField.Equals(value) != true)) {
                    this.NAKNADA_BANKA_POSTOField = value;
                    this.RaisePropertyChanged("NAKNADA_BANKA_POSTO");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string NAKNADA_DEPOZITARNOJ_BANCI {
            get {
                return this.NAKNADA_DEPOZITARNOJ_BANCIField;
            }
            set {
                if ((object.ReferenceEquals(this.NAKNADA_DEPOZITARNOJ_BANCIField, value) != true)) {
                    this.NAKNADA_DEPOZITARNOJ_BANCIField = value;
                    this.RaisePropertyChanged("NAKNADA_DEPOZITARNOJ_BANCI");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string NAKNADA_IZLAZNA {
            get {
                return this.NAKNADA_IZLAZNAField;
            }
            set {
                if ((object.ReferenceEquals(this.NAKNADA_IZLAZNAField, value) != true)) {
                    this.NAKNADA_IZLAZNAField = value;
                    this.RaisePropertyChanged("NAKNADA_IZLAZNA");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string NAKNADA_ULAZNA {
            get {
                return this.NAKNADA_ULAZNAField;
            }
            set {
                if ((object.ReferenceEquals(this.NAKNADA_ULAZNAField, value) != true)) {
                    this.NAKNADA_ULAZNAField = value;
                    this.RaisePropertyChanged("NAKNADA_ULAZNA");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string NAKNADA_ZA_UPRAVLJANJEM_FONDA {
            get {
                return this.NAKNADA_ZA_UPRAVLJANJEM_FONDAField;
            }
            set {
                if ((object.ReferenceEquals(this.NAKNADA_ZA_UPRAVLJANJEM_FONDAField, value) != true)) {
                    this.NAKNADA_ZA_UPRAVLJANJEM_FONDAField = value;
                    this.RaisePropertyChanged("NAKNADA_ZA_UPRAVLJANJEM_FONDA");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string NALOG_OPIS_PLACANJA {
            get {
                return this.NALOG_OPIS_PLACANJAField;
            }
            set {
                if ((object.ReferenceEquals(this.NALOG_OPIS_PLACANJAField, value) != true)) {
                    this.NALOG_OPIS_PLACANJAField = value;
                    this.RaisePropertyChanged("NALOG_OPIS_PLACANJA");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string NALOG_PBO {
            get {
                return this.NALOG_PBOField;
            }
            set {
                if ((object.ReferenceEquals(this.NALOG_PBOField, value) != true)) {
                    this.NALOG_PBOField = value;
                    this.RaisePropertyChanged("NALOG_PBO");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string NALOG_PBO_MODEL {
            get {
                return this.NALOG_PBO_MODELField;
            }
            set {
                if ((object.ReferenceEquals(this.NALOG_PBO_MODELField, value) != true)) {
                    this.NALOG_PBO_MODELField = value;
                    this.RaisePropertyChanged("NALOG_PBO_MODEL");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string NALOG_PRIMATELJ_RACUN {
            get {
                return this.NALOG_PRIMATELJ_RACUNField;
            }
            set {
                if ((object.ReferenceEquals(this.NALOG_PRIMATELJ_RACUNField, value) != true)) {
                    this.NALOG_PRIMATELJ_RACUNField = value;
                    this.RaisePropertyChanged("NALOG_PRIMATELJ_RACUN");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string NALOG_PRIMATELJ_VBDI {
            get {
                return this.NALOG_PRIMATELJ_VBDIField;
            }
            set {
                if ((object.ReferenceEquals(this.NALOG_PRIMATELJ_VBDIField, value) != true)) {
                    this.NALOG_PRIMATELJ_VBDIField = value;
                    this.RaisePropertyChanged("NALOG_PRIMATELJ_VBDI");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string NALOG_SIFRA_NAMJENE {
            get {
                return this.NALOG_SIFRA_NAMJENEField;
            }
            set {
                if ((object.ReferenceEquals(this.NALOG_SIFRA_NAMJENEField, value) != true)) {
                    this.NALOG_SIFRA_NAMJENEField = value;
                    this.RaisePropertyChanged("NALOG_SIFRA_NAMJENE");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string NAPOMENA_ZA_KUPNJU {
            get {
                return this.NAPOMENA_ZA_KUPNJUField;
            }
            set {
                if ((object.ReferenceEquals(this.NAPOMENA_ZA_KUPNJUField, value) != true)) {
                    this.NAPOMENA_ZA_KUPNJUField = value;
                    this.RaisePropertyChanged("NAPOMENA_ZA_KUPNJU");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string NAPOMENA_ZA_ODREGISTRACIJU {
            get {
                return this.NAPOMENA_ZA_ODREGISTRACIJUField;
            }
            set {
                if ((object.ReferenceEquals(this.NAPOMENA_ZA_ODREGISTRACIJUField, value) != true)) {
                    this.NAPOMENA_ZA_ODREGISTRACIJUField = value;
                    this.RaisePropertyChanged("NAPOMENA_ZA_ODREGISTRACIJU");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string NAPOMENA_ZA_PRODAJU {
            get {
                return this.NAPOMENA_ZA_PRODAJUField;
            }
            set {
                if ((object.ReferenceEquals(this.NAPOMENA_ZA_PRODAJUField, value) != true)) {
                    this.NAPOMENA_ZA_PRODAJUField = value;
                    this.RaisePropertyChanged("NAPOMENA_ZA_PRODAJU");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string NAPOMENA_ZA_REGISTRACIJU {
            get {
                return this.NAPOMENA_ZA_REGISTRACIJUField;
            }
            set {
                if ((object.ReferenceEquals(this.NAPOMENA_ZA_REGISTRACIJUField, value) != true)) {
                    this.NAPOMENA_ZA_REGISTRACIJUField = value;
                    this.RaisePropertyChanged("NAPOMENA_ZA_REGISTRACIJU");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string NAZIV {
            get {
                return this.NAZIVField;
            }
            set {
                if ((object.ReferenceEquals(this.NAZIVField, value) != true)) {
                    this.NAZIVField = value;
                    this.RaisePropertyChanged("NAZIV");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string NAZIV_KATEGORIJE {
            get {
                return this.NAZIV_KATEGORIJEField;
            }
            set {
                if ((object.ReferenceEquals(this.NAZIV_KATEGORIJEField, value) != true)) {
                    this.NAZIV_KATEGORIJEField = value;
                    this.RaisePropertyChanged("NAZIV_KATEGORIJE");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string NAZIV_VLASNIKA {
            get {
                return this.NAZIV_VLASNIKAField;
            }
            set {
                if ((object.ReferenceEquals(this.NAZIV_VLASNIKAField, value) != true)) {
                    this.NAZIV_VLASNIKAField = value;
                    this.RaisePropertyChanged("NAZIV_VLASNIKA");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string OSOBNA_ISKAZNICA_URL {
            get {
                return this.OSOBNA_ISKAZNICA_URLField;
            }
            set {
                if ((object.ReferenceEquals(this.OSOBNA_ISKAZNICA_URLField, value) != true)) {
                    this.OSOBNA_ISKAZNICA_URLField = value;
                    this.RaisePropertyChanged("OSOBNA_ISKAZNICA_URL");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public System.Nullable<decimal> POCETNA_CIJENA_UDJELA {
            get {
                return this.POCETNA_CIJENA_UDJELAField;
            }
            set {
                if ((this.POCETNA_CIJENA_UDJELAField.Equals(value) != true)) {
                    this.POCETNA_CIJENA_UDJELAField = value;
                    this.RaisePropertyChanged("POCETNA_CIJENA_UDJELA");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string PRAVILA_URL {
            get {
                return this.PRAVILA_URLField;
            }
            set {
                if ((object.ReferenceEquals(this.PRAVILA_URLField, value) != true)) {
                    this.PRAVILA_URLField = value;
                    this.RaisePropertyChanged("PRAVILA_URL");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public System.Nullable<int> PROFIL_RIZICNOSTI_ID {
            get {
                return this.PROFIL_RIZICNOSTI_IDField;
            }
            set {
                if ((this.PROFIL_RIZICNOSTI_IDField.Equals(value) != true)) {
                    this.PROFIL_RIZICNOSTI_IDField = value;
                    this.RaisePropertyChanged("PROFIL_RIZICNOSTI_ID");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public System.Nullable<decimal> PROSLA_VRIJEDNOST {
            get {
                return this.PROSLA_VRIJEDNOSTField;
            }
            set {
                if ((this.PROSLA_VRIJEDNOSTField.Equals(value) != true)) {
                    this.PROSLA_VRIJEDNOSTField = value;
                    this.RaisePropertyChanged("PROSLA_VRIJEDNOST");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string PROSPEKT_URL {
            get {
                return this.PROSPEKT_URLField;
            }
            set {
                if ((object.ReferenceEquals(this.PROSPEKT_URLField, value) != true)) {
                    this.PROSPEKT_URLField = value;
                    this.RaisePropertyChanged("PROSPEKT_URL");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public System.Nullable<int> REGIJA_ID {
            get {
                return this.REGIJA_IDField;
            }
            set {
                if ((this.REGIJA_IDField.Equals(value) != true)) {
                    this.REGIJA_IDField = value;
                    this.RaisePropertyChanged("REGIJA_ID");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string RIZICNOST {
            get {
                return this.RIZICNOSTField;
            }
            set {
                if ((object.ReferenceEquals(this.RIZICNOSTField, value) != true)) {
                    this.RIZICNOSTField = value;
                    this.RaisePropertyChanged("RIZICNOST");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public System.Nullable<int> SEKTOR_ID {
            get {
                return this.SEKTOR_IDField;
            }
            set {
                if ((this.SEKTOR_IDField.Equals(value) != true)) {
                    this.SEKTOR_IDField = value;
                    this.RaisePropertyChanged("SEKTOR_ID");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public System.Nullable<int> TIP_ULAGANJA_ID {
            get {
                return this.TIP_ULAGANJA_IDField;
            }
            set {
                if ((this.TIP_ULAGANJA_IDField.Equals(value) != true)) {
                    this.TIP_ULAGANJA_IDField = value;
                    this.RaisePropertyChanged("TIP_ULAGANJA_ID");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public System.Nullable<int> TIP_UPRAVLJANJA_ID {
            get {
                return this.TIP_UPRAVLJANJA_IDField;
            }
            set {
                if ((this.TIP_UPRAVLJANJA_IDField.Equals(value) != true)) {
                    this.TIP_UPRAVLJANJA_IDField = value;
                    this.RaisePropertyChanged("TIP_UPRAVLJANJA_ID");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public System.Nullable<int> TRZISTE_ID {
            get {
                return this.TRZISTE_IDField;
            }
            set {
                if ((this.TRZISTE_IDField.Equals(value) != true)) {
                    this.TRZISTE_IDField = value;
                    this.RaisePropertyChanged("TRZISTE_ID");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string VALUTA {
            get {
                return this.VALUTAField;
            }
            set {
                if ((object.ReferenceEquals(this.VALUTAField, value) != true)) {
                    this.VALUTAField = value;
                    this.RaisePropertyChanged("VALUTA");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string VALUTA_SIFRA {
            get {
                return this.VALUTA_SIFRAField;
            }
            set {
                if ((object.ReferenceEquals(this.VALUTA_SIFRAField, value) != true)) {
                    this.VALUTA_SIFRAField = value;
                    this.RaisePropertyChanged("VALUTA_SIFRA");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public System.Nullable<System.DateTime> VRIJEDI_DO {
            get {
                return this.VRIJEDI_DOField;
            }
            set {
                if ((this.VRIJEDI_DOField.Equals(value) != true)) {
                    this.VRIJEDI_DOField = value;
                    this.RaisePropertyChanged("VRIJEDI_DO");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public System.Nullable<System.DateTime> VRIJEDI_OD {
            get {
                return this.VRIJEDI_ODField;
            }
            set {
                if ((this.VRIJEDI_ODField.Equals(value) != true)) {
                    this.VRIJEDI_ODField = value;
                    this.RaisePropertyChanged("VRIJEDI_OD");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public System.Nullable<decimal> VRIJEDNOST {
            get {
                return this.VRIJEDNOSTField;
            }
            set {
                if ((this.VRIJEDNOSTField.Equals(value) != true)) {
                    this.VRIJEDNOSTField = value;
                    this.RaisePropertyChanged("VRIJEDNOST");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public System.Nullable<System.DateTime> VRIJEDNOST_DATUM {
            get {
                return this.VRIJEDNOST_DATUMField;
            }
            set {
                if ((this.VRIJEDNOST_DATUMField.Equals(value) != true)) {
                    this.VRIJEDNOST_DATUMField = value;
                    this.RaisePropertyChanged("VRIJEDNOST_DATUM");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string ZAHTJEV_REPORT_ID {
            get {
                return this.ZAHTJEV_REPORT_IDField;
            }
            set {
                if ((object.ReferenceEquals(this.ZAHTJEV_REPORT_IDField, value) != true)) {
                    this.ZAHTJEV_REPORT_IDField = value;
                    this.RaisePropertyChanged("ZAHTJEV_REPORT_ID");
                }
            }
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Runtime.Serialization", "4.0.0.0")]
    [System.Runtime.Serialization.DataContractAttribute(Name="StructuralObject", Namespace="http://schemas.datacontract.org/2004/07/System.Data.Objects.DataClasses", IsReference=true)]
    [System.SerializableAttribute()]
    [System.Runtime.Serialization.KnownTypeAttribute(typeof(ServiceClient.ServiceReference1.ComplexObject))]
    [System.Runtime.Serialization.KnownTypeAttribute(typeof(ServiceClient.ServiceReference1.TraziFondove_Result))]
    public partial class StructuralObject : object, System.Runtime.Serialization.IExtensibleDataObject, System.ComponentModel.INotifyPropertyChanged {
        
        [System.NonSerializedAttribute()]
        private System.Runtime.Serialization.ExtensionDataObject extensionDataField;
        
        [global::System.ComponentModel.BrowsableAttribute(false)]
        public System.Runtime.Serialization.ExtensionDataObject ExtensionData {
            get {
                return this.extensionDataField;
            }
            set {
                this.extensionDataField = value;
            }
        }
        
        public event System.ComponentModel.PropertyChangedEventHandler PropertyChanged;
        
        protected void RaisePropertyChanged(string propertyName) {
            System.ComponentModel.PropertyChangedEventHandler propertyChanged = this.PropertyChanged;
            if ((propertyChanged != null)) {
                propertyChanged(this, new System.ComponentModel.PropertyChangedEventArgs(propertyName));
            }
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Runtime.Serialization", "4.0.0.0")]
    [System.Runtime.Serialization.DataContractAttribute(Name="ComplexObject", Namespace="http://schemas.datacontract.org/2004/07/System.Data.Objects.DataClasses", IsReference=true)]
    [System.SerializableAttribute()]
    [System.Runtime.Serialization.KnownTypeAttribute(typeof(ServiceClient.ServiceReference1.TraziFondove_Result))]
    public partial class ComplexObject : ServiceClient.ServiceReference1.StructuralObject {
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Runtime.Serialization", "4.0.0.0")]
    [System.Runtime.Serialization.DataContractAttribute(Name="CompositeType", Namespace="http://schemas.datacontract.org/2004/07/Service")]
    [System.SerializableAttribute()]
    public partial class CompositeType : object, System.Runtime.Serialization.IExtensibleDataObject, System.ComponentModel.INotifyPropertyChanged {
        
        [System.NonSerializedAttribute()]
        private System.Runtime.Serialization.ExtensionDataObject extensionDataField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private bool BoolValueField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string StringValueField;
        
        [global::System.ComponentModel.BrowsableAttribute(false)]
        public System.Runtime.Serialization.ExtensionDataObject ExtensionData {
            get {
                return this.extensionDataField;
            }
            set {
                this.extensionDataField = value;
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public bool BoolValue {
            get {
                return this.BoolValueField;
            }
            set {
                if ((this.BoolValueField.Equals(value) != true)) {
                    this.BoolValueField = value;
                    this.RaisePropertyChanged("BoolValue");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string StringValue {
            get {
                return this.StringValueField;
            }
            set {
                if ((object.ReferenceEquals(this.StringValueField, value) != true)) {
                    this.StringValueField = value;
                    this.RaisePropertyChanged("StringValue");
                }
            }
        }
        
        public event System.ComponentModel.PropertyChangedEventHandler PropertyChanged;
        
        protected void RaisePropertyChanged(string propertyName) {
            System.ComponentModel.PropertyChangedEventHandler propertyChanged = this.PropertyChanged;
            if ((propertyChanged != null)) {
                propertyChanged(this, new System.ComponentModel.PropertyChangedEventArgs(propertyName));
            }
        }
    }
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ServiceModel.ServiceContractAttribute(ConfigurationName="ServiceReference1.IFondServis")]
    public interface IFondServis {
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IFondServis/GetData", ReplyAction="http://tempuri.org/IFondServis/GetDataResponse")]
        string GetData(string value);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IFondServis/VratiFondove", ReplyAction="http://tempuri.org/IFondServis/VratiFondoveResponse")]
        ServiceClient.ServiceReference1.TraziFondove_Result[] VratiFondove();
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IFondServis/GetDataUsingDataContract", ReplyAction="http://tempuri.org/IFondServis/GetDataUsingDataContractResponse")]
        ServiceClient.ServiceReference1.CompositeType GetDataUsingDataContract(ServiceClient.ServiceReference1.CompositeType composite);
    }
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public interface IFondServisChannel : ServiceClient.ServiceReference1.IFondServis, System.ServiceModel.IClientChannel {
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public partial class FondServisClient : System.ServiceModel.ClientBase<ServiceClient.ServiceReference1.IFondServis>, ServiceClient.ServiceReference1.IFondServis {
        
        public FondServisClient() {
        }
        
        public FondServisClient(string endpointConfigurationName) : 
                base(endpointConfigurationName) {
        }
        
        public FondServisClient(string endpointConfigurationName, string remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public FondServisClient(string endpointConfigurationName, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public FondServisClient(System.ServiceModel.Channels.Binding binding, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(binding, remoteAddress) {
        }
        
        public string GetData(string value) {
            return base.Channel.GetData(value);
        }
        
        public ServiceClient.ServiceReference1.TraziFondove_Result[] VratiFondove() {
            return base.Channel.VratiFondove();
        }
        
        public ServiceClient.ServiceReference1.CompositeType GetDataUsingDataContract(ServiceClient.ServiceReference1.CompositeType composite) {
            return base.Channel.GetDataUsingDataContract(composite);
        }
    }
}
