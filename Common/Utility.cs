using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Drawing;

namespace InvestApp.Common
{
	public class Utility
	{
		public static Bitmap CreateThumbnail(string lcFilename, int newWidth, int newHeight)
		{
			Bitmap bmpOut = null;
			try
			{
				Bitmap srcImg = new Bitmap(lcFilename);
				System.Drawing.Imaging.ImageFormat loFormat = srcImg.RawFormat;

				int calcNewWidth = 0;
				int calcNewHeight = 0;

				//*** If the image is smaller than a thumbnail just return it
				if (srcImg.Width < newWidth && srcImg.Height < newHeight)
					return srcImg;

				decimal thumbRatio = newWidth / (decimal)newHeight;
				decimal imgRatio = srcImg.Width / (decimal)srcImg.Height;

				if (imgRatio > thumbRatio)
				{
					calcNewHeight = srcImg.Height;
					calcNewWidth = (int)(srcImg.Height * thumbRatio);
				}
				else
				{
					calcNewWidth = srcImg.Width;
					calcNewHeight = (int)(srcImg.Width / thumbRatio);
				}

				//if (srcImg.Width > srcImg.Height)
				//{
				//	lnRatio = (decimal)newWidth / srcImg.Width;
				//	calcNewWidth = newWidth;
				//	decimal lnTemp = srcImg.Height * lnRatio;
				//	calcNewHeight = (int)lnTemp;
				//}
				//else
				//{
				//	lnRatio = (decimal)newHeight / srcImg.Height;
				//	calcNewHeight = newHeight;
				//	decimal lnTemp = srcImg.Width * lnRatio;
				//	calcNewWidth = (int)lnTemp;
				//}

				Rectangle srcRect = new Rectangle(0, 0, calcNewWidth, calcNewHeight);

				if (calcNewWidth < srcImg.Width)
					srcRect.Offset((srcImg.Width - calcNewWidth) / 2, 0);
				else if (calcNewHeight < srcImg.Height)
					srcRect.Offset(0, (srcImg.Height - calcNewHeight) / 2);


				bmpOut = new Bitmap(newWidth, newHeight);
				Graphics g = Graphics.FromImage(bmpOut);
				g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic;
				g.FillRectangle(Brushes.White, 0, 0, calcNewWidth, calcNewHeight);

				g.DrawImage(srcImg, new Rectangle(0, 0, newWidth, newHeight), srcRect, GraphicsUnit.Pixel);

				srcImg.Dispose();
			}
			catch
			{
				return null;
			}

			return bmpOut;
		}

		public static string DateTimeToString(DateTime? dateTime)
		{
			return dateTime.HasValue ? dateTime.Value.ToString("dd.MM.yyyy") : "";
		}

		public static string DecimalToString(decimal? value)
		{
			if(!value.HasValue)
				value = 0;

			return value.Value.ToString("n");
		}

		public static decimal? StringToDecimal(string value)
		{
			decimal valDecimal;

			if (value.IsNullOrEmpty() || !decimal.TryParse(value, out valDecimal))
				return null;
			else
				return valDecimal;
		}

		public static int? StringToInt(string value)
		{
			int valInt;

			if (value.IsNullOrEmpty() || !int.TryParse(value, out valInt))
				return null;
			else
				return valInt;
		}

		public static DateTime? StringToDateTime(string value)
		{
			DateTime dateValue;

			if (string.IsNullOrEmpty(value) || !DateTime.TryParse(value, out dateValue))
				return null;
			else
				return dateValue;
		}

		public static DateTime? DateTimeToNullable(DateTime value)
		{
			return value == DateTime.MinValue ? (DateTime?)null : value;
		}

		public static bool StringPromijenjen(string str1, string str2)
		{
			if ( (string.IsNullOrEmpty(str1) && !string.IsNullOrEmpty(str2)) ||
				 (!string.IsNullOrEmpty(str1) && string.IsNullOrEmpty(str2)) )
				return true;

			if (string.IsNullOrEmpty(str1) && string.IsNullOrEmpty(str2))
				return false;

			return !str1.Equals(str2);
		}

		public static bool DatumPromijenjen(DateTime? dat1, DateTime? dat2)
		{
			if(dat1 == null && dat2 != null || dat1 != null && dat2 == null)
				return true;

			if (dat1 == null && dat2 == null)
				return false;

			return !dat1.Equals(dat2);
		}

		public static string NormalizeString(string value)
		{
			if (string.IsNullOrEmpty(value.Trim()))
				return null;
			else
				return value;
		}

		/// <summary>
		/// Vraća prvi string koji nije null/emtpy
		/// </summary>
		public static string StringNvl(params string[] values)
		{
			foreach (string val in values)
			{
				if (!string.IsNullOrEmpty(val))
					return val;
			}

			return null;
		}

		public static DatotekaTip VratiTipDatoteke(string fileName)
		{
			switch (System.IO.Path.GetExtension(fileName).ToLower())
			{
				case ".jpg":
				case ".jpeg":
				case ".bmp":
				case ".png":
				case ".gif":
					return DatotekaTip.Slika;
				case ".pdf":
					return DatotekaTip.PDF;
				case ".doc":
				case ".docx":
					return DatotekaTip.Doc;
				default:
					return DatotekaTip.Ostalo;
			}
		}

		public static string VratiDatotekaIkonaUrl(string fileName)
		{
			DatotekaTip tip = VratiTipDatoteke(fileName);

			switch (tip)
			{
				case DatotekaTip.PDF:
					return "~/Images/dok_pdf.png";
				case DatotekaTip.Slika:
					return "~/Images/dok_image.png";
				case DatotekaTip.Doc:
					return "~/Images/dok_office_doc.png";
				case DatotekaTip.Ostalo:
					return "~/Images/dok_default.png";
				default:
					return "";
			}
		}

		public static DateTime PrethodniRadniDan()
		{
			DateTime prethodiDan = DateTime.Today.AddDays(-1);

			if (prethodiDan.DayOfWeek == DayOfWeek.Sunday)
				prethodiDan = prethodiDan.AddDays(-2);
			else if (prethodiDan.DayOfWeek == DayOfWeek.Saturday)
				prethodiDan = prethodiDan.AddDays(-1);

			return prethodiDan;
		}
	}

	public static class BuiltInExtensions
	{
		public static bool IsNullOrEmpty(this string str)
		{
			return string.IsNullOrEmpty(str);
		}

		/// <summary>
		/// Ako je string duži od zadane dužine, skraćuje ga
		/// </summary>
		/// <param name="str"></param>
		/// <param name="maxLength"></param>
		/// <returns></returns>
		public static string EnsureMaxLength(this string str, int maxLength)
		{
			if (string.IsNullOrEmpty(str) || str.Length <= maxLength)
				return str;
			else
				return str.Substring(0, maxLength);
		}
	}
}
