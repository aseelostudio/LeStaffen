using Godot;
using System;

namespace HP
{
    public partial class HealthManager : Node
    {
        [Signal] public delegate void HitTakenEventHandler();
        [Signal] public delegate void DeathEventHandler();
        [Signal] public delegate void InvicibilityChangedEventHandler();
        [Signal] public delegate void HealthChangedEventHandler();

        private int _maxHealthPoints = 3;
        private int _healthPoints = 3;
        private bool _isInvincible = false;

        [Export] public float _invicibilityTime = 0.3f;
        

        [Export] public int MaxHealthPoints
        {
            get { return _maxHealthPoints; }
            private set
            {
                _maxHealthPoints = value;
            }
        }


        /// <summary>
        /// 
        /// </summary>
        public int HealthPoints
        {
            get { return _healthPoints; }
            private set
            {
                if(value < _healthPoints)
                {
                    if (_isInvincible)
                        return;

                    if (value < 0)
                    {
                        _healthPoints = 0;
                        EmitSignal(SignalName.Death);
                    }
                    else
                    {
                        _healthPoints = value;
                        EmitSignal(SignalName.HitTaken);
                        StartInvicible();
                    }

                }
                else
                {
                    if (value > _maxHealthPoints)
                    {
                        _healthPoints = _maxHealthPoints;
                    }
                    else
                    {
                        _healthPoints = value;
                    }
                }

                EmitSignal(SignalName.HealthChanged);
            }
        }

        public bool IsInvicible 
        { 
            get { return _isInvincible; } 
            private set
            {
                if(value == true)
                {
                    _invincibilityTimer.Start();
                }
                else
                {
                    _invincibilityTimer.Stop();
                }

                _isInvincible = value;
                EmitSignal(SignalName.InvicibilityChanged);
            }
        }


        
        private Timer _invincibilityTimer;

        public override void _Ready()
        {
            _invincibilityTimer = new Timer()
            {
                WaitTime = _invicibilityTime,
                Autostart = false,
                OneShot = true,
                Name = "Invicibility"
            };
            AddChild(_invincibilityTimer);

            _invincibilityTimer.Timeout += StopInvicible;

            HealthPoints = _maxHealthPoints;
        }

        /// <summary>
        /// Called when all HP has to be replenished.
        /// </summary>
        public void Replenish()
        {
            HealthPoints = _maxHealthPoints;
        }

        /// <summary>
        /// Method called when some <paramref name="damage"/> > 0 has to be inflicted
        /// </summary>
        public void TakeHit(int damage)
        {
            HealthPoints -= damage;
        }

        /// <summary>
        /// Called when a new max value for the HP has to be set.
        /// </summary>
        /// <param name="newMax"></param>
        public void NewMax(int newMax)
        {
            MaxHealthPoints = newMax;
        }

        public void StartInvicible()
        {
            IsInvicible = true;            
        }

        public void StopInvicible()
        {
            IsInvicible = false;
        }

    }

}
