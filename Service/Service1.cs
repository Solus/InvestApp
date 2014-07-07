using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;
using InvestApp.DAL;

namespace Service
{
	// NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "Service1" in both code and config file together.
	public class FondServis : IFondServis
	{
		public string GetData(string value)
		{
			return string.Format("You entered: {0}", value);
		}

		public List<TraziFondove_Result> VratiFondove()
		{
            //var data = FondDAC.TraziFondove(null, null, null, null, null, null, null, null, null).ToList();
            return null;// data;
		}

		public CompositeType GetDataUsingDataContract(CompositeType composite)
		{
			if (composite == null)
			{
				throw new ArgumentNullException("composite");
			}
			if (composite.BoolValue)
			{
				composite.StringValue += "Suffix";
			}
			return composite;
		}
	}
}
