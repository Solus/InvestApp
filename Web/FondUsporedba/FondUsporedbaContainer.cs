using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace InvestApp.Web
{
	[Serializable]
	public class FondUsporedbaContainer
	{
		private List<Int32> _fondoviUsporedba;

		private const int _MAX_FONDOVA = 4;
		private const string _SESSION_ID = "_FONDOVI_USPOREDBA_QUEUE_";

		public int BrojFondova
		{
			get { return _fondoviUsporedba == null ? 0 : _fondoviUsporedba.Count; }
		}

		public bool IsFull
		{
			get
			{
				return _fondoviUsporedba != null && _fondoviUsporedba.Count == _MAX_FONDOVA;
			}
		}

		/// <summary>
		/// 
		/// </summary>
		/// <param name="session"></param>
		public static void Init(HttpSessionState session)
		{
			session[_SESSION_ID] = new FondUsporedbaContainer();
		}

		/// <summary>
		/// 
		/// </summary>
		/// <param name="session"></param>
		/// <returns></returns>
		public static FondUsporedbaContainer GetContainer(HttpSessionState session)
		{
			return session[_SESSION_ID] as FondUsporedbaContainer;
		}

		/// <summary>
		/// 
		/// </summary>
		/// <param name="session"></param>
		public FondUsporedbaContainer()
		{
			_fondoviUsporedba = new List<Int32>();
		}

		public bool SadrziFond(Int32 fondId)
		{
			return _fondoviUsporedba.Contains(fondId);
		}

		/// <summary>
		/// 
		/// </summary>
		/// <param name="fondId"></param>
		public bool AddFond(Int32 fondId)
		{
			if (_fondoviUsporedba.Count == _MAX_FONDOVA || SadrziFond(fondId))
			{
				//_fondoviUsporedba.RemoveAt(0);
				return false;
			}

			_fondoviUsporedba.Add(fondId);

			return true;
		}

		/// <summary>
		/// 
		/// </summary>
		/// <param name="fondId"></param>
		public bool RemoveFond(Int32 fondId)
		{
			return _fondoviUsporedba.Remove(fondId);
		}

		/// <summary>
		/// 
		/// </summary>
		/// <returns></returns>
		public List<Int32> Fondovi()
		{
			return _fondoviUsporedba;
		}
	}
}